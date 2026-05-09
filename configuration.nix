{ config, pkgs,  ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 10;
    };
    systemd-boot.enable = false;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  hardware.graphics = {
    enable = true;
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epsonscan2 ];
  };

  services.tlp.enable = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr2 ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    xkb.layout = "us,eg";
    xkb.options = "grp:caps_toggle";
    autoRepeatRate = 35;
    autoRepeatDelay = 300;
  };

  services.displayManager.ly.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
    };
  };

  users.users.mostafa = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "lp" "scanner" ];
    shell = pkgs.bash;
  };
  
  programs = {
    bash.enable = true
  };

  environment.systemPackages = with pkgs; [
    tmux alacritty git curl wget ripgrep
    unzip zip file xclip neovim  maim
    brave pcmanfm yt-dlp mangowc
  ];


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" ];
  nixpkgs.config.allowUnfree = true; 

  system.stateVersion = "25.11"; 
}
