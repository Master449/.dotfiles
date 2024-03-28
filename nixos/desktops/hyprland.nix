{ lib, config, pkgs, ... }:

{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
