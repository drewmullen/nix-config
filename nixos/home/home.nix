{ config, pkgs, libs, ... }:
let
  pkgs = import ../../pin { snapshot = "nixpkgs-unstable_0"; };
  nixos-unstable = import ../../pin { snapshot = "nixos-unstable_0"; };
in
{
  
  home.packages = with pkgs; [
    discord
    exercism
    handbrake
    jq
    latte-dock
    nerdfonts
    nixpkgs-fmt
    openssh
    playonlinux
    riot-desktop
    simplescreenrecorder
    spectacle
    spotify
    slack
    signal-desktop
    steam
    steam-run
    terminator
    tigervnc
    virtualgl
    vlc
    vscode
    wireguard-tools
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    #initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/nixos_zshrc.zsh;
    #plugins = [{
    #  name = "powerlevel10k";
    #}];
  };

  nixpkgs.config.allowUnfree = true;
  # services.lorri.enable = true;
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
