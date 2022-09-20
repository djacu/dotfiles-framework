{
  config,
  pkgs,
  ...
}: {
  boot.supportedFilesystems = ["zfs"];
  networking.hostId = "f1d0b215";
  boot.zfs.devNodes = "/dev/disk/by-id";
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  swapDevices = [
    { device = "/dev/disk/by-id/nvme-WD_BLACK_SN850_1TB_204178806629-part4"; randomEncryption.enable = true; }
  ];
  systemd.services.zfs-mount.enable = false;
  environment.etc."machine-id".source = "/state/etc/machine-id";
  environment.etc."zfs/zpool.cache".source = "/state/etc/zfs/zpool.cache";
  boot.loader.efi.efiSysMountPoint = "/boot/efis/nvme-WD_BLACK_SN850_1TB_204178806629-part1";

  # boot loader specific config
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "2";

  users.users.root.initialHashedPassword = "$6$13srfFWQP.3ASRu6$2MaNi9.R9sQ70azNS1nO8LdcGkJy3lJHHEqtuPMChBmu9uHf9RIF7hwkcYQyTB/El/l4m0FKfG7dlQjrOTn7r/";
}

