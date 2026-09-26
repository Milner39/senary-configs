{
  infuse,
  ...
}:

[(final: prev: infuse prev {
  boot.kernel.package.__assign = final.pkgs.linux_6_6;

  boot.initrd.contents."early/run".__prepend = [''
    echo initrd: executing /early/run
    mkdir -p /root
    mount -t tmpfs -o size=100m none /root
    mkdir /root/run /root/dev /root/proc /root/sys /root/tmp /root/root /root/etc /root/bin
    mkdir -p /root/nix/var/nix/profiles/per-user
    mkdir -p /root/nix/store
    modprobe 9p
    modprobe 9pnet_virtio
    modprobe virtio_pci
    mount -t 9p -o trans=virtio,ro,msize=512000,version=9p2000.L nixstore /root/nix/store
  ''];
})]
