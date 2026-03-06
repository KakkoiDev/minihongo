#!/usr/bin/env python3
"""
Dev server with watch + live reload.

- Serves docs/ on localhost:8000
- Watches site/ and data/ for changes
- Rebuilds and injects live-reload signal

Usage: python site/dev.py [--port 8000]
"""

import argparse
import hashlib
import http.server
import os
import sys
import threading
import time
from pathlib import Path

ROOT = Path(__file__).parent
PROJECT = ROOT.parent
DOCS = PROJECT / "docs"
WATCH_DIRS = [ROOT, PROJECT / "data"]
WATCH_EXTENSIONS = {'.html', '.css', '.js', '.json', '.csv', '.py', '.svg', '.png'}

# Injected into every HTML response for live reload
RELOAD_SCRIPT = '''
<script>
(function() {
  let hash = '';
  setInterval(async () => {
    try {
      const r = await fetch('/__reload__');
      const h = await r.text();
      if (hash && h !== hash) location.reload();
      hash = h;
    } catch {}
  }, 500);
})();
</script>
'''


def compute_hash():
    """Hash watched source files to detect changes."""
    h = hashlib.md5()
    for d in WATCH_DIRS:
        if not d.exists():
            continue
        for f in sorted(d.rglob('*')):
            if f.is_file() and f.suffix in WATCH_EXTENSIONS:
                try:
                    h.update(f.read_bytes())
                except OSError:
                    pass
    return h.hexdigest()[:12]


class DevHandler(http.server.SimpleHTTPRequestHandler):
    """HTTP handler with live-reload endpoint and HTML injection."""

    def __init__(self, *args, state=None, **kwargs):
        self.state = state
        super().__init__(*args, directory=str(DOCS), **kwargs)

    def do_GET(self):
        if self.path == '/__reload__':
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain')
            self.send_header('Cache-Control', 'no-store')
            self.end_headers()
            self.wfile.write(self.state['hash'].encode())
            return

        # Rewrite clean URLs: /ja/ -> /ja/index.html
        if self.path.endswith('/'):
            self.path += 'index.html'

        super().do_GET()

    def send_response_only(self, code, message=None):
        super().send_response_only(code, message)

    def end_headers(self):
        # Disable caching in dev
        self.send_header('Cache-Control', 'no-store')
        super().end_headers()

    def copyfile(self, source, outputfile):
        # Inject reload script into HTML responses
        if hasattr(self, '_headers_buffer'):
            headers = b''.join(self._headers_buffer).decode(errors='replace')
            if 'text/html' in headers:
                content = source.read()
                if isinstance(content, bytes):
                    content = content.decode('utf-8', errors='replace')
                content = content.replace('</body>', f'{RELOAD_SCRIPT}</body>')
                outputfile.write(content.encode('utf-8'))
                return
        super().copyfile(source, outputfile)

    def log_message(self, format, *args):
        # Suppress reload polling logs
        if '/__reload__' in str(args):
            return
        super().log_message(format, *args)


def rebuild():
    """Run build.py and return True on success."""
    # Import build from same directory
    sys.path.insert(0, str(ROOT))
    try:
        import importlib
        import build
        importlib.reload(build)
        build.build()
        return True
    except Exception as e:
        print(f"\n  BUILD ERROR: {e}\n")
        return False
    finally:
        sys.path.pop(0)


def watch_loop(state):
    """Watch for file changes and rebuild."""
    while True:
        time.sleep(0.5)
        new_hash = compute_hash()
        if new_hash != state['source_hash']:
            state['source_hash'] = new_hash
            print("\n  Change detected, rebuilding...")
            if rebuild():
                state['hash'] = new_hash
                print("  Ready.\n")


def main():
    parser = argparse.ArgumentParser(description='Minihongo dev server')
    parser.add_argument('--port', type=int, default=8000)
    args = parser.parse_args()

    # Initial build
    print("Building...")
    rebuild()

    source_hash = compute_hash()
    state = {'hash': source_hash, 'source_hash': source_hash}

    # Start file watcher
    watcher = threading.Thread(target=watch_loop, args=(state,), daemon=True)
    watcher.start()

    # Start server
    handler = lambda *a, **kw: DevHandler(*a, state=state, **kw)
    server = http.server.HTTPServer(('', args.port), handler)
    print(f"\n  http://localhost:{args.port}/\n")

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopped.")
        server.server_close()


if __name__ == "__main__":
    main()
