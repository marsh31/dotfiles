#!/bin/bash
#
# NAME:   09-troubleshooting/pacman_qochecker.sh
# AUTHOR: marsh
#
# NOTE:
#
#   pacman -Qo xx


arr=(
"/usr/lib/node_modules/npm/docs/content/commands/npm-query.md"
"/usr/lib/node_modules/npm/docs/content/using-npm/dependency-selectors.md"
"/usr/lib/node_modules/npm/docs/output/commands/npm-query.html"
"/usr/lib/node_modules/npm/docs/output/using-npm/dependency-selectors.html"
"/usr/lib/node_modules/npm/lib/commands/query.js"
"/usr/lib/node_modules/npm/node_modules/.bin/cssesc"
"/usr/lib/node_modules/npm/node_modules/@npmcli/arborist/lib/query-selector-all.js"
"/usr/lib/node_modules/npm/node_modules/@npmcli/fs/lib/mkdir.js"
"/usr/lib/node_modules/npm/node_modules/@npmcli/query/LICENSE"
"/usr/lib/node_modules/npm/node_modules/@npmcli/query/lib/index.js"
"/usr/lib/node_modules/npm/node_modules/@npmcli/query/package.json"
"/usr/lib/node_modules/npm/node_modules/cssesc/LICENSE-MIT.txt"
"/usr/lib/node_modules/npm/node_modules/cssesc/README.md"
"/usr/lib/node_modules/npm/node_modules/cssesc/bin/cssesc"
"/usr/lib/node_modules/npm/node_modules/cssesc/cssesc.js"
"/usr/lib/node_modules/npm/node_modules/cssesc/man/cssesc.1"
"/usr/lib/node_modules/npm/node_modules/cssesc/package.json"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/API.md"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/LICENSE-MIT"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/index.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/parser.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/processor.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/attribute.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/className.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/combinator.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/comment.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/constructors.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/container.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/guards.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/id.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/index.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/namespace.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/nesting.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/node.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/pseudo.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/root.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/selector.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/string.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/tag.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/types.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/selectors/universal.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/sortAscending.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/tokenTypes.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/tokenize.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/util/ensureObject.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/util/getProp.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/util/index.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/util/stripComments.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/dist/util/unesc.js"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/package.json"
"/usr/lib/node_modules/npm/node_modules/postcss-selector-parser/postcss-selector-parser.d.ts"
)

for item in "${arr[@]}"; do
  # echo "sudo mv $item $item.txt"
  # sudo mv $item "$item.txt"
  echo "sudo rm $item.txt"
  sudo rm $item.txt
done
