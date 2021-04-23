# Git Metadata Helper

Extract metadata from your git repository

## Usage

```yml
- name: Extract Metadata
  uses: forewing/git-metadata@v1
```

Note: you need set `fetch-depth: 0` for checkout action to provide repository information needed by this action.

```yml
- name: Checkout
  uses: actions/checkout@v2
  with:
    fetch-depth: 0
```

## Outputs

| ID | Description | Exception |
| :- | :- | :- |
| `tag-current`         | Current tag name | "unknown" |
| `tag-last`            | Last tag name | "unknown" |
| `changes-since-last`  | Changes since last tag | "nothing" |
| `changes-formatted`   | Markdown-Formatted version of changes-since-last | "## Changes\n\n- nothing" |


## Integrations

Example to create a beautiful release by simply pushing a git tag to remote

```yml
name: Create Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    name: Build & Release
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 0

      - name: Extract Metadata
        id: extract
        uses: forewing/git-metadata@v1

      - name: Release
        uses: softprops/action-gh-release@v1
        with:
          body: ${{ steps.extract.outputs.changes-formatted }}
          name: Release ${{ steps.extract.outputs.tag-current }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
