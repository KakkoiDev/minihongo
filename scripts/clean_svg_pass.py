#!/usr/bin/env python3
"""Turn filled/traced vocabulary SVGs into small, consistent monoline SVGs.

Requires Inkscape plus Pillow, NumPy and scikit-image. Run from the repository
root. The output directory must differ from the input directory.
"""
import argparse
import math
import subprocess
import tempfile
from pathlib import Path

import numpy as np
from PIL import Image
from skimage.measure import label, regionprops
from skimage.morphology import remove_small_objects, skeletonize

INK = '#221c18'
RED = '#b5372b'
NEIGHBORS = [(dy, dx) for dy in (-1, 0, 1) for dx in (-1, 0, 1) if (dy, dx) != (0, 0)]


def rdp(points, epsilon):
    if len(points) < 3:
        return points
    start, end = np.array(points[0]), np.array(points[-1])
    line = end - start
    norm = np.linalg.norm(line)
    offsets = np.array(points) - start
    distances = (np.linalg.norm(offsets, axis=1) if norm == 0
                 else np.abs(line[0] * offsets[:, 1] - line[1] * offsets[:, 0]) / norm)
    index = int(np.argmax(distances))
    if distances[index] <= epsilon:
        return [points[0], points[-1]]
    return rdp(points[:index + 1], epsilon)[:-1] + rdp(points[index:], epsilon)


def skeleton_paths(mask):
    pixels = {tuple(p) for p in np.argwhere(skeletonize(remove_small_objects(mask, max_size=10)))}
    if not pixels:
        return []

    def adjacent(p):
        y, x = p
        return [(y + dy, x + dx) for dy, dx in NEIGHBORS if (y + dy, x + dx) in pixels]

    nodes = {p for p in pixels if len(adjacent(p)) != 2}
    used = set()
    chains = []

    def edge(a, b):
        return tuple(sorted((a, b)))

    for start in sorted(nodes):
        for nxt in adjacent(start):
            if edge(start, nxt) in used:
                continue
            chain = [start, nxt]
            used.add(edge(start, nxt))
            prev, cur = start, nxt
            while cur not in nodes:
                choices = [p for p in adjacent(cur) if p != prev]
                if not choices:
                    break
                follow = choices[0]
                used.add(edge(cur, follow))
                chain.append(follow)
                prev, cur = cur, follow
            chains.append(chain)

    # Closed loops have no endpoint/junction node.
    for start in sorted(pixels):
        remaining = [p for p in adjacent(start) if edge(start, p) not in used]
        if not remaining:
            continue
        chain = [start, remaining[0]]
        used.add(edge(*chain))
        prev, cur = chain
        while True:
            choices = [p for p in adjacent(cur) if p != prev and edge(cur, p) not in used]
            if not choices:
                break
            follow = choices[0]
            used.add(edge(cur, follow))
            chain.append(follow)
            prev, cur = cur, follow
            if cur == start:
                break
        chains.append(chain)
    return chains


def path_data(chain, scale=0.5):
    points = [(x * scale, y * scale) for y, x in chain]
    points = rdp(points, 0.8)
    if len(points) < 2:
        return ''
    commands = [f'M{points[0][0]:.1f} {points[0][1]:.1f}']
    commands.extend(f'L{x:.1f} {y:.1f}' for x, y in points[1:])
    if np.linalg.norm(np.array(points[0]) - np.array(points[-1])) < 1.2:
        commands.append('Z')
    return ''.join(commands)


def masks(image):
    rgba = np.asarray(image.convert('RGBA'))
    visible = rgba[:, :, 3] >= 96
    r, g, b = rgba[:, :, 0], rgba[:, :, 1], rgba[:, :, 2]
    red = visible & (r > g * 1.28) & (r > b * 1.18) & (r > 85)
    return visible & ~red, red


def convert(source, target, render_path):
    subprocess.run([
        'inkscape', str(source), '--export-type=png', '--export-width=256',
        f'--export-filename={render_path}',
    ], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    image = Image.open(render_path)
    black, red = masks(image)
    compact = []
    red_lines = red.copy()
    red_labels = label(red)
    for region in regionprops(red_labels):
        if 20 <= region.area <= 900 and region.solidity > 0.82 and region.eccentricity < 0.8:
            red_lines[red_labels == region.label] = False
            cy, cx = region.centroid
            radius = math.sqrt(region.area / math.pi) / 2
            compact.append(f'<circle cx="{cx/2:.1f}" cy="{cy/2:.1f}" r="{radius:.1f}"/>')

    def paths_for(mask):
        result = []
        for chain in skeleton_paths(mask):
            data = path_data(chain)
            if data:
                result.append(f'<path d="{data}"/>')
        return result

    paths = paths_for(black)
    accents = paths_for(red_lines)
    svg = (
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128" width="128" height="128">'
        f'<g fill="none" stroke="{INK}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round">'
        + ''.join(paths) + '</g>'
        f'<g fill="none" stroke="{RED}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round">'
        + ''.join(accents) + '</g>'
        f'<g fill="{RED}">' + ''.join(compact) + '</g></svg>\n'
    )
    target.write_text(svg, encoding='utf-8')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory() as temp:
        for source in sorted(args.input.glob('word-*.svg')):
            convert(source, args.output / source.name, Path(temp) / f'{source.stem}.png')


if __name__ == '__main__':
    main()
