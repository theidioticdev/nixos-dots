{ config, pkgs, pkgs-unstable, ... }:

{
imports = [
  ./hardware-configuration.nix
];


hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
  ];
};

services.tlp.enable = true;

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking.hostName = "nixos-btw";
networking.networkmanager.enable = true;

time.timeZone = "Africa/Cairo";
i18n.defaultLocale = "en_US.UTF-8";

services.xserver = {
    enable = true;
    xkb.layout = "us,eg";
    xkb.options = "grp:caps_toggle";
    windowManager.oxwm.enable = true;
};
services.displayManager.ly.enable = true;

services.picom = {
    enable = true;
};
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
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
};

environment.systemPackages = with pkgs; [
    alacritty tmux neovim
    dmenu rofi dunst
    brave pcmanfm telegram-desktop
    yt-dlp git
    curl wget ripgrep
    gum pv boxes
];
fonts.packages = with pkgs; [
    nerd-fonts.iosevka
];

programs.zsh.enable = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true; 
system.stateVersion = "25.11"; 
}
