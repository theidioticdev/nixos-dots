{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # --- Bootloader (GRUB for EFI) ---
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # Change to /boot/efi if your hardware-config says so
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 10; # Prevents GRUB from becoming a wall of text
    };
    systemd-boot.enable = false;
  };

  # --- Storage Optimization (Crucial for 256GB) ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true; # Deduplicates files to save space

  # --- Hardware & Graphics ---
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epsonscan2 ];
  };

  services.tlp.enable = true;

  # --- Networking & Localization ---
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Services ---
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ]; # Your L3150 Driver
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us,eg";
    xkb.options = "grp:caps_toggle";
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

  # --- User Space ---
  users.users.mostafa = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "lp" "scanner" ];
    shell = pkgs.zsh;
  };
  
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # System Essentials
    foot tmux vim git curl wget ripgrep
    unzip zip file wl-clipboard
    
    # Wayland / MangoWM stack
    mangowc
    fuzzel mako waybar
    grim slurp
    
    # Apps
    brave pcmanfm yt-dlp
    epsonscan2
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # --- Nix System Settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; 

  system.stateVersion = "25.11"; 
}
