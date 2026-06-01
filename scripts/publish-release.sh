#!/usr/bin/env sh
# Publish/replace a single rolling GitHub release WITHOUT a delete-first window.
#
# The old `gh release delete ... && gh release create ...` pattern deleted the live
# release (and its tag) before recreating it. If the create then failed - exactly the
# gh auth/network flakiness seen in practice - the release was gone with nothing in its
# place and users got a 404. This never deletes: it creates the release if absent, and
# otherwise replaces the assets in place (--clobber) and refreshes title/notes. Any
# failure leaves the previously published release fully intact.
#
# Usage: publish-release.sh <tag> <title> <asset>...
set -eu

if [ "$#" -lt 3 ]; then
	echo "usage: publish-release.sh <tag> <title> <asset>..." >&2
	exit 2
fi

tag=$1
title=$2
shift 2
notes=$(git log -5 --oneline)

if gh release view "$tag" >/dev/null 2>&1; then
	gh release upload "$tag" "$@" --clobber
	gh release edit "$tag" --title "$title" --notes "$notes"
	echo "updated release '$tag' in place ($# asset(s))"
else
	gh release create "$tag" "$@" --title "$title" --notes "$notes"
	echo "created release '$tag' ($# asset(s))"
fi
