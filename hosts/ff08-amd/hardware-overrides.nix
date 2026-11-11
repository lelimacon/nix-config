{
  ...
}:
{

  # Data partition (nvme0n1p6, btrfs).
  fileSystems."/x" =
  {
    device = "/dev/disk/by-uuid/938aec2a-aba6-4d2d-a521-be790bc981c9";
    fsType = "btrfs";
    options =
    [
      "noatime"
      "compress=zstd:3"
      "nofail" # Do not block boot when the drive is missing.
      "x-systemd.device-timeout=10s"
    ];
  };

  # Make the mount point usable by the user.
  systemd.tmpfiles.rules =
  [
    "d /x 0755 lelimacon users -"
  ];
}
