{
  network.description = "Nix the hard way, experimental Kubernetes deployment";
  kube-nix =
    { config, pkgs, modulesPath, ... }:
    {
      deployment = {
        targetHost = "nix.gesz.dev";
      };

      imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

      boot = {
        loader.grub = {
          efiSupport = true;
          efiInstallAsRemovable = true;
          device = "nodev";
        };
        initrd.kernelModules = [ "nvme" ];
        tmpOnTmpfs = true;
      };

      networking = {
        hostName = "kube-nix";
        firewall.allowPing = true;
      };

      services = {
        openssh.enable = true;
      };

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3luLP4zUjd+AX7VA2LTBkCNVv9OA/nPT4cBqHmilGS84LiWC15zFTc84ybqWPmxme0Y9ACR0ok1p8InmuCUSTdgzQ2b2JakxH9ryS4uyKCmxRhrN7z3b3fOax5SHW5P6MGhvvVNpzef5b/OpqLEsfxO4AjgRgk1gx/6Z8y4333N/D74jO8Da1x/3KTpIi0MBMSGUShce2b6sny64s4covW0wcEniCXc86HjG/mn9lP91dpyXydt9gNYFvg2fby+u4WCXSwCelHSVL8hb8piuw/2cAhveDnzgCgoF2HISan5yg394giEssheU1ySGU+MtuxoErUb/6isxX7ewoEKMV gergely@gregorian"
      ];
      fileSystems."/boot" = { device = "/dev/disk/by-uuid/3A52-0EBB"; fsType = "vfat"; };
      fileSystems."/" = { device = "/dev/vda1"; fsType = "ext4"; };


      environment.systemPackages = with pkgs; [ neofetch vim ];
    };
}
