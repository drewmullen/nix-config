# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./machine/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp42s0.useDHCP = true;
  networking.interfaces.wlp39s0.useDHCP = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      ubuntu_font_family
      fira-code
      fira-code-symbols
    ];
    fontconfig.defaultFonts = {
      sansSerif = ["Ubuntu"];
      monospace = ["Fira Code"];
    };
  };

  # Set your time zone.
  time.timeZone = "American/New_York";

  users.extraUsers.dm = {
    description = "Drew Mullen";
    group = "dm";
    extraGroups = [
      "audio"
      "libvirtd"
      "networkmanager"
      "users"
      "video"
      "wheel"
    ];

    uid = 1000;

    createHome = true;
    home = "/home/dm";
    shell = "/run/current-system/sw/bin/bash";

    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDS2+nKlXIfDKognnFCqeHhToxWS3eJJ5BDoatH6BFsx1KJqzp7fdzc79vi8729QPbnjkJ3G0DdV+FqS1wdYiNjbGbJhEY+OjJ700lSPeQI0UzFbVz3bA8+8xgPHvMJKqnJSLvr61WF7INnUvCKsTRYtHLuG3Wj8doZ/P8F+dj4U0nQRpbjBMsE1p04XJdWzQdFtMwTFQ0B2dYVvXjvlnmPdjH9d3ODlUnM8XAP+DqtzfLaqcylEIKJz8BB+bQsekFvhsHso+FUiXv1hGZbjjIYEsvYLr0j2klU+3gfPk2aUYgSro9N4bb9aYfTqTI4bnCx7KUholIw7gIIh9KnrNPR dmullen@AdminisatorsMBP.attlocal.net"];
  };
  users.extraGroups.dm.gid = 1000;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    setLdLibraryPath = true;
  };

  # Virtualization
  virtualisation.libvirtd.enable = true;
  boot.extraModulePackages = "options kvm_amd nested=1";

  # Enable Docker
  virtualisation.docker = {
    enable = false;
    enableNvidia = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    busybox
    chromium
    firefox
    vim
    slack
    git
    kdeApplications.knotes
    unzip
  ];

  nix = {
    autoOptimiseStore = true;
    trustedUsers = [ "root" "@wheel" ];
  };

   services.plex = {
     enable = true;
     openFirewall = true;
   };


  services.sshd.enable = true;
  #Enable openssh
  services.openssh = {
   enable = true;
   forwardX11 = true;

   permitRootLogin = "no";

   # only public key auth
   passwordAuthentication = false;
   challengeResponseAuthentication = false;
   };

  #programs.ssh.forwardX11 = true;
  #programs.ssh.setXAuthLocation = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

