{ lib, config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> 
  ./modules/configFiles.nix
  ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # This has to be here sadly
  programs.steam.enable = true;

  users.users.david = {
    description = "David Flowers";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirt" ];
    isNormalUser = true;
    packages = with pkgs; [
      alacritty
      discord
      steam
      tailscale
      virt-manager
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

    home.file."${config.users.users.david.home}/.config/autostart/discord.desktop" = {
      text = ''
[Desktop Entry]
Exec=Discord
Icon=discord
Name=Discord
Type=Application
      '';
    };
    home.file."${config.users.users.david.home}/.config/htop/htoprc" = {
      text = (builtins.readFile ./config/htoprc);
    };

#  configFiles = {
#    enable = true;
#    files = [
#      { target = ".config/discord.desktop"; source = "./config/discordAutostart"; }
#      { target = ".config/htop/htoprc"; source = "./config/htoprc"; }
#      # Add more configurations as needed
#    ];
#  };

home.stateVersion = "23.11";
  };
}
