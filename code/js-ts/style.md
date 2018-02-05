# Coding Style

## Required Extensions

- [EditorConfig](http://editorconfig.org/#download)
- [Prettier](https://prettier.io/docs/en/editors.html)
- [TS Hero](https://marketplace.visualstudio.com/items?itemName=rbbit.typescript-hero)

### Editor Config (`.editorconfig`)

Handles spacing, newline.

```
root = true

[*]
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
trim_trailing_whitespace = true
```

### Prettier (`.prettierrc`)

Formats code automatically.

```json
{
  "parser": "typescript",
  "singleQuote": true,
  "trailingComma": "all",
  "arrowParens": "always"
}
```

### TS Hero (`no config required`)

Sort and remove unused imports.
