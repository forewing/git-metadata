# Git Metadata

Extract metadata from your git repository

## Usage

```yml
- name: Extract Metadata
  uses: forewing/git-metadata@master
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
