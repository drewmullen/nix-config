#! /usr/bin/env bash

# Shows the output of every command
set +x

# # Nix configuration

ln -s $(pwd)/nixos/configuration.nix /etc/nixos/configuration.nix
ln -s $(pwd)/nixos/machine/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# # Home manager configuration
mkdir -p $HOME/.config
ln -s $(pwd)/nixos/home/home.nix $HOME/.config/nixpkgs/home.nix
ln -s $(pwd)/nixos/home/config.nix $HOME/.config/nixpkgs/config.nix
