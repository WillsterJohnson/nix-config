# WillsterJohnson's Daily NixOS

A lightweight NixOS config for web development.

## Usage

The `nixup` script will run the appropriate `nixos-rebuild` command, as well
as performing some other useful tasks including committing to git and restarting
the shell with `exec zsh`.

## What Do We Have Here?

-   [Apps](#apps)
-   [Software](#software)
-   [Utilities](#utilities)
-   [Fonts](#fonts)
-   [OS UI](#os-ui)
-   [Configuration](#configuration)
    -   [NixOS](#nixos)
    -   [Home Manager](#home-manager)

### Apps

Anything you open in a window.

-   [Zed (text editor)](https://zed.dev)
-   [FireFox (Web Browser)](https://www.mozilla.org/en-GB/firefox)

### Software

Anything you run in a terminal.

-   [Bun (TypeScript runtime, `npm` replacement)](https://bun.sh)
-   [Zoxide (a smarter `cd` command)](https://github.com/ajeetdsouza/zoxide)
-   [Gitmoji (a better `git commit`)](https://gitmoji.dev/)
-   [Buni (`bun i` for monorepos)](./hosts/default/.homefiles/buni/readme.md)

### Utilities

Anything which works in the background.

### Fonts

They're fonts.

### OS UI

Desktop environment, window manager, etc.
