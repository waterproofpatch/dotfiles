# Dotfiles
Personal repo for dotfiles and installer scripts to help setting up new dev environments.

The installer script creates a backup of any existing ~/.vim in ~/.dotfiles_backup_<timestamp> before attempting to 
copy the supplied .* into the home directory (~/), installing vim plugins from github and downloading command line utilities required for the install (git, python-pip, curl, etc.)

## Usage

```bash
./install.sh <os>
e.g.
./install.sh darwin
... or
./install.sh debian
```
