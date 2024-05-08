{ config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./userspace.nix 
    ./desktops/plasma6.nix
#    ./desktops/gnome.nix
    ./modules/virtualization.nix
    ./modules/samba.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ 
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos-unstable"
    "nixos-config=/home/david/Documents/.dotfiles/nixos/configuration.nix" 
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    btop
    curl
    xdelta
    git
    htop
    jdk17
    killall
    lutris
    neofetch
    neovim
    nvtopPackages.full
    p7zip
    tailscale
    wget
    wl-clipboard
    wine
    winetricks
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

  networking.hostName = "nixbox";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    printing.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver.videoDrivers = [ "amdgpu" ];
  };

  time.timeZone = "America/Chicago";
  
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
