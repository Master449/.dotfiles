{ lib, config, pkgs, ... }:

{
  fileSystems."/mnt/media" = {
    device = "\\192.168.5.218";
    fsType = "cfis";
    options = [ "username=david" "password=Some12hold" "x-systemd.automound" "noauto" ];
  };
}
