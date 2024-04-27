{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myConfigFiles;
in
{
    imports = [ <home-manager/nixos> ];
    options.myConfigFiles = {
    enable = mkEnableOption "myConfigFiles";

    files = mkOption {
      type = types.listOf (types.attrsOf types.path);
      default = [];
      example = literalExample ''
        [
          { target = ".config/autorun.desktop"; source = "/path/to/autorun"; }
          { target = ".config/myProgram/config.ini"; source = "/path/to/config"; }
        ]
      '';
      description = "List of files to manage.";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.david.home.file = builtins.foldl' (acc: file: acc // {
      ${file.target}.source = file.source;
    }) {} cfg.files;
  };
}

