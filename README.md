# Dotfiles

Repository for configuration files organized by packages.

## Requirements

- GNU Stow
- Git (for version control)

## Installation

1. Clone this repository to your home directory:
```bash
git clone https://github.com/leonardys/dotfiles.git ~/dotfiles
```

2. Use GNU Stow to create symlinks per package:
```bash
cd ~/dotfiles
stow <package_name>
```

## Usage

- Configuration files are organized with package names as the top directory
- To add new configurations, create a new directory with the package name and add your files
- To update existing configurations, modify the files in this repository
- To remove configurations, use `stow -D <package>` to delete symlinks
- To symlink per package, use `stow <package_name>`

## License

MIT
