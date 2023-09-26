{ lib, config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  programs.steam.enable = true;

  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirt" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      discord
      kate
      steam
      tailscale
      virt-manager
      vivaldi
    ];
  };  
  
  home-manager.users.david = { pkgs, ... }: {
    programs = {
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

      git = {
        enable = true;
        userName = "David Flowers II";
	userEmail = "master4491@gmail.com";
      };
    };
    home.stateVersion = "23.05";
  };
}
