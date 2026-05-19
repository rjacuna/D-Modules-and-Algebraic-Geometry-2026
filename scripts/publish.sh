#!/usr/bin/env bash
#
# Build the site and stage the artifacts (index.html + assets/) onto the
# local Dist branch as a new commit. Leaves Dist's content/*.md files
# untouched so any text edited directly on Dist (program abstracts, speaker
# list, etc.) is preserved.
#
# This script does NOT push. Review the commit, then push manually:
#
#   git log Dist -1 --stat   # review
#   git push origin Dist     # publish
#
# Usage:  scripts/publish.sh

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

SRC_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
SRC_SHA="$(git rev-parse --short HEAD)"

echo "==> Building from $SRC_BRANCH@$SRC_SHA..."
npm run build

if [ ! -f target/index.html ] || [ ! -d target/assets ]; then
  echo "ERROR: build did not produce target/index.html or target/assets/" >&2
  exit 1
fi

WORKTREE="$(mktemp -d -t dmod-dist-XXXXXX)"
cleanup() { git worktree remove --force "$WORKTREE" >/dev/null 2>&1 || true; }
trap cleanup EXIT

echo "==> Preparing Dist worktree at $WORKTREE..."
git fetch --quiet origin Dist
if git show-ref --verify --quiet refs/heads/Dist; then
  git worktree add --quiet "$WORKTREE" Dist
  git -C "$WORKTREE" merge --ff-only origin/Dist >/dev/null
else
  git worktree add --quiet -b Dist "$WORKTREE" origin/Dist
fi

echo "==> Replacing artifacts (preserving content/*.md)..."
rm -f  "$WORKTREE/index.html"
rm -rf "$WORKTREE/assets"
cp     "$REPO_ROOT/target/index.html" "$WORKTREE/index.html"
cp -R  "$REPO_ROOT/target/assets"     "$WORKTREE/assets"

if [ -z "$(git -C "$WORKTREE" status --porcelain)" ]; then
  echo "==> No artifact changes. Nothing to publish."
  exit 0
fi

git -C "$WORKTREE" add index.html assets
git -C "$WORKTREE" commit --quiet -m "Publish build artifacts from $SRC_BRANCH@$SRC_SHA"

NEW_SHA="$(git -C "$WORKTREE" rev-parse --short HEAD)"
echo "==> Committed $NEW_SHA on local Dist branch."
echo ""
echo "    Review:   git log Dist -1 --stat"
echo "    Publish:  git push origin Dist"
