{ lib, config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  programs.steam.enable = true;

  users.users.david = {
    isNormalUser = true;
    description = "David Flowers";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirt" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      alacritty
      discord
      steam
      tailscale
      virt-manager
    ];
  };  
  
  home-manager.users.david = { pkgs, ... }: {
    programs = {
      
      alacritty = {
	enable = true;
	settings = {
	  
	  font = {
	    size = 12;
	    offset.x = 1;
	    offset.y = 0;

 	    family = "JetBrainsMono Nerd Font";
	    #bold.style = "Bold";
	  };

	  window = {
	    padding.x = 5;
	    padding.y = 2;
	    dimensions.columns = 105;
	    dimensions.lines = 30;
	  };
	};
      };

      git = {
        enable = true;
        userName = "David Flowers II";
	userEmail = "master4491@gmail.com";
      };


      neovim = {
        enable = true;
        plugins = [
	  pkgs.vimPlugins.nvim-treesitter
	];
       extraConfig = ''
set expandtab
set ignorecase
set number
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
	};
	plugins = [
	  {
	    name = "powerlevel10k";
	    src = pkgs.zsh-powerlevel10k;
	    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	  }
	  {
	    name = "powerlevel10k-config";
	    src = ./p10k-config;
	    file = "p10k.zsh";
	  }
	];
      };
    };
    home.stateVersion = "23.11";
  };
}