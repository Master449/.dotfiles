{ config, pkgs, ... }:
let
  unstableTarball = 
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz; 
in
{
  imports = [ 
    ./hardware-configuration.nix 
    ./userspace.nix 
    ./desktops/plasma.nix
    ];

  # Bootloader.
  boot = {
    
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amd_iommu=on" "iommu=pt" "iommu=1" ];
    
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        default = "saved";
      };
    };
    
    supportedFilesystems = [ "ntfs" ];
  
  };

  environment.systemPackages = with pkgs; [
    alacritty
    curl
    firefox
    git
    jdk17
    libvirt
    neofetch
    unstable.neovim
    qemu
    tailscale
    wget
    wl-clipboard
    zsh
  ];
  
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

  networking.hostName = "nixbox"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: with pkgs; {
        unstable = import unstableTarball {
	  config = config.nixpkgs.config;
	};
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.flatpak.enable = true;

  time.timeZone = "America/Chicago";
  
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

  
  programs.steam.enable = true;
  programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
