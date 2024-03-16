{ lib, config, pkgs, ... }:

{
  services.xserver.enable = true;

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
