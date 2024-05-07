{ lib, config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager = {
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
