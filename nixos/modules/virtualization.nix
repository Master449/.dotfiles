{ lib, config, pkgs, ... }:

{
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" "iommu=1" ];
  boot.kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  
  systemd.services.libvirtd.preStart = ''
   # Copy hook files
   cp -rf /home/david/Documents/.dotfiles/hooks /var/lib/libvirt/
   chmod 755 /var/lib/libvirt/hooks
  
   # Make them executable
   chmod +x /var/lib/libvirt/hooks/qemu
   chmod +x /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh
   chmod +x /var/lib/libvirt/hooks/qemu.d/win10/release/end/revert.sh
   chmod +x /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
   chmod +x /var/lib/libvirt/hooks/qemu.d/win11/release/end/revert.sh
  
   # Change their groups
   chgrp -R libvirtd /var/lib/libvirt/hooks
  '';

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libvirt
    qemu
  ];
}