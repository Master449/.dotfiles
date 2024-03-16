{ lib, config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";

    displayManager = {
      defaultSession="plasmawayland";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  
    desktopManager.plasma5 = {
      enable = true;
    };
  };
}
