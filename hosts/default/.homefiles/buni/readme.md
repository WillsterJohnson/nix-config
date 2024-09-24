# `buni`

`buni` is a simple wrapper around [Bun](https://bun.sh/) to provide better
support for monorepo package installation.

It's admittedly inefficient, but it will create the necessary symlinks to both
`node_modules` packages and local monorepo packages declared via `workspace:*`.

## Usage

```zsh
buni [args...]                         # install in root package
buni [args...] --pkg <path/to/package> # install in a specific package
```
