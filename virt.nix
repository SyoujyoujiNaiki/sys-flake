let
  gpuIDs = [
    "10de:28e0" # Graphics
    "10de:22be" # Audio
  ];
in { config, lib, pkgs, ... }:

{
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
    ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
  ];


  virtualisation.libvirtd.enable = true;

  # Enable TPM emulation (optional)
  virtualisation.libvirtd.qemu = {
    swtpm.enable = true;
    ovmf.packages = [ pkgs.OVMFFull.fd ];
  };

  # Enable USB redirection (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  # Enable virt-manager
  programs.virt-manager.enable = true;

  # enable local user access to libvirt
  users.users.naiki.extraGroups = [ "libvirtd" ];
}
