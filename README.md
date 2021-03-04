# Dotfiles

In this repository I mantain my dotfiles for the following apps:

- vim
- bash
- git
- gnuplot
- screen 
- latexmk
- ...

## Installation:

This repository is meant to be installed with GNU `stow` or `stowsh` (a bash
implementation).

- `git clone thisrepo`
- `cd thisrepo`
- `make install`

It will automatically pull a shell version of `stow` and use it to symlink all your files.

## Usage:

### Modules

The repository is modular.

`make module`

### Clean

`make clean`


### Add a file

`make add somefile` ??
or
`./dotadd somefile`??
