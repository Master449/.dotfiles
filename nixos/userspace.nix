{ lib, config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> 
  ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # This has to be here sadly
  programs.steam.enable = true;
  programs.dconf.enable = true; 
  
  users.users.david = {
    description = "David Flowers";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirt" "libvirtd" ];
    isNormalUser = true;
    packages = with pkgs; [
      vscode
      discord
      dolphin
      prismlauncher
      steam
      tailscale
      virt-manager
      vivaldi
    ];
    shell = pkgs.zsh;
  };  
  home-manager.users.david = { pkgs, ... }: {
    programs = {
      alacritty = {
      enable = true;
      settings = {
        
        font = {
          family = "JetBrainsMono Nerd Font";
          offset.x = 0;
          offset.y = 0;
          size = 11;
        };

        window = {
          dimensions.columns = 105;
          dimensions.lines = 30;
          padding.x = 5;
          padding.y = 2;
          title = "Terminal";
        };
      };
          };

      git = {
        enable = true;
      	userEmail = "20436145+Master449@users.noreply.github.com";
        userName = "David";
      };


      neovim = {
        enable = true;
        extraConfig = ''
set number relativenumber
set clipboard=unnamedplus
        '';
      };

      zsh = {
        initExtra = ''
source /home/david/.p10k.zsh
        '';
        enable = true;
        shellAliases = {
          ga = "git add";
          gc = "git commit";
          gp = "git push";
          gs = "git status";
          ll = "ls -Al --group-directories-first";
	      l = "la -lh --group-directories-first";
	      nix-boot = "sudo nixos-rebuild boot";
	      nix-switch = "sudo nixos-rebuild switch";
      };
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./misc/p10k-config;
          file = "p10k.zsh";
        }
      ];
    };
  };
    home.file.".config" = {
      source = ./dotfiles;
      recursive = true;
    };

  home.stateVersion = "23.11";
  };
}
