{ lib, config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix <home-manager/nixos> ];

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    grub = {
       efiSupport = true;
       #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
       device = "nodev";
       useOSProber = true;
       default = "saved";
    };
  };

  # Passthrough of devices to Virtual Machines
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" "iommu=1" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Locale / Time Related
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Desktop Environment
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;

  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirt" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      discord
      kate
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
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
      curl
      git
      libvirt
      neofetch
      neovim
      qemu
      wget
      wl-clipboard
      zsh
  ];

  system.stateVersion = "23.05"; # Did you read the comment?

}
