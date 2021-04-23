# Git Metadata

Extract metadata from your git repository

## Usage

```yml
- name: Extract Metadata
  uses: forewing/git-metadata@master
```

## Outputs

| ID | Description | Exception |
| :- | :- | :- |
| `tag-current`         | Current tag name | "unknown" |
| `tag-last`            | Last tag name | "unknown" |
| `changes-since-last`  | Changes since last tag | "nothing" |
| `changes-formatted`   | Markdown-Formatted version of changes-since-last | "## Changes\n\n- nothing" |
