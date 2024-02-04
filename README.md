# ZachHung's dotfiles

My personal dotfiles configuration using GNU Stow.

## Prerequisites

### Install GNU Stow

#### Using Ubuntu

```bash
sudo apt-install stow
```

#### Using Arch

```bash
sudo pacman -S stow
```

## Guide

1. Clone this repo:

```bash
git clone https://github.com/ZachHung/dotfiles.git
```

2. Go into dotfiles folder

```bash
cd dotfiles/
```

3. Use stow to create symlink to the `$HOME` directory (Make sure u have stow installed)

```bash
stow .
```
