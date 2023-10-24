# Users groups module
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/users-groups.nix

{ config, options, pkgs, pkgs_unstable, user, system, inputs, ... }:

{
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel" # Enable sudo
      ];
      initialPassword = "password";
      packages = (with pkgs; [
        # Others
        bottom
        croc
        zoxide
        zsh
        starship
        rustup
        inputs.xremap-flake.packages.${system}.default

        # Wayland
        (waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        })) # Status bar
        dunst # Notification
        swww # Wallpaper
        rofi-wayland # App launcher
        networkmanagerapplet # Network manager applet
        grim # Screenshot
        slurp # Select region (for e.g. screenshot)
        wl-clipboard # Clipboard CLI
        swappy # Screenshot editing tool
        cliphist # Clipboard manager
        wlsunset # Day/night gamma adjustment

        # Applications
        imv # Image viewer
        hyprpicker # Color picker
        clapper # Media/video player
        celluloid # Media/video player
        gnome.seahorse # GNOME keyring GUI
        helvum # Pipewire GUI

      ]) ++ (with pkgs_unstable; [
        # Others (unstable)
        supabase-cli
        gh

        # Applications (unstable)
        brave
        vscode
        firefox-devedition
        kitty
        krita
      ]);
    };
  };
}