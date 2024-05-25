{ config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./userspace.nix 
    ./desktops/plasma6.nix
    ./modules/virtualization.nix
    ./modules/samba.nix
    ];

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 14d";
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
        useOSProber = false;
        default = "saved";
        extraEntries = ''
menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-20A4-5216' {
	savedefault
	insmod part_gpt
	insmod fat
	search --no-floppy --fs-uuid --set=root 20A4-5216
	chainloader /efi/Microsoft/Boot/bootmgfw.efi
}
menuentry 'Ubuntu 24.04 LTS (24.04) (on /dev/sda2)' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-99e0a120-c9dd-4a1c-b757-be1d72d9d192' {
	savedefault
	insmod part_gpt
	insmod ext2
	set root='hd0,gpt2'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt2 --hint-efi=hd0,gpt2 --hint-baremetal=ahci0,gpt2  99e0a120-c9dd-4a1c-b757-be1d72d9d192
	else
	  search --no-floppy --fs-uuid --set=root 99e0a120-c9dd-4a1c-b757-be1d72d9d192
	fi
	linux /boot/vmlinuz root=UUID=99e0a120-c9dd-4a1c-b757-be1d72d9d192 ro quiet splash $vt_handoff
	initrd /boot/initrd.img
}
'';
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
    btop
    curl
    xdelta
    firefox
    git
    htop
    jdk17
    killall
    kitty
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
  networking.iproute2.enable = true;
  networking.networkmanager.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  security.rtkit.enable = true;

  services = {
    printing.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    tor.enable = true;
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
