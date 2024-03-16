{ lib, config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

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
	    size = 11;
	    offset.x = 1;
	    offset.y = 0;

 	    family = "JetBrainsMono Nerd Font";
	  };

	  window = {
	    blur = true;
	    dimensions.columns = 105;
	    dimensions.lines = 30;
	    opacity = 0.9;
	    padding.x = 5;
	    padding.y = 2;
	    title = "Terminal";
	  };
	};
      };

      git = {
        enable = true;
        userName = "David";
	userEmail = "20436145+Master449@users.noreply.github.com";
      };


      neovim = {
        enable = true;
       	extraConfig = ''
set tabstop=2 shiftwidth=2 expandtab | retab
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
	    src = ./misc/p10k-config;
	    file = "p10k.zsh";
	  }
	];
      };
    };
    home.stateVersion = "23.11";
  };
}
