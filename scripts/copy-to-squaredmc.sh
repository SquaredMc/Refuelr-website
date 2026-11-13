#!/bin/sh
# Copy the site into a checkout of the SquaredMc website repo, which serves it
# at https://squaredmc.com/nearempty/. Commit and push that repo to publish.
#
#   scripts/copy-to-squaredmc.sh ../SquaredMc-website
set -e
cd "$(dirname "$0")/.."
DEST="${1:?usage: $0 <path to SquaredMc website checkout>}/public/nearempty"
rm -rf "$DEST"
mkdir -p "$DEST"
cp index.html privacy.html terms.html support.html 404.html sitemap.xml "$DEST"/
cp -R css js assets "$DEST"/
echo "Copied to $DEST"
