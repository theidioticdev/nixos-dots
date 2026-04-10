{ config, pkgs, pkgs-unstable, ... }:

{
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
};
services.displayManager.ly.enable = true;

services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
};


users.users.mostafa = {
isNormalUser = true;
extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" ];
shell = pkgs.zsh;
};

environment.systemPackages = with pkgs; [
    alacritty tmux neovim
    dmenu rofi dunst picom
    brave pcmanfm telegram-desktop
    yt-dlp git
    curl wget ripgrep
    gum pv boxes
];


programs.zsh.enable = true;
nix.settings.experimental-features = [ "nix-command" "flakes" ];
nixpkgs.config.allowUnfree = true; 
system.stateVersion = "25.11"; 
}
