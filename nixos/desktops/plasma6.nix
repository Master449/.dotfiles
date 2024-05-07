{ lib, config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.enable = true;

  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };
  
  environment.systemPackages = with pkgs; [
    kdePackages.kdenlive
    kdePackages.kate
  ];
}
