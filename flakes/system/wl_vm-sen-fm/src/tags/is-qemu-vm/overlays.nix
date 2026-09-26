{
  infuse,
  ...
}:

[(final: prev: infuse prev {
  boot.initrd.contents."early/run".__prepend = [''
    echo initrd: executing /early/run
    mkdir -p /root
    mount -t tmpfs -o size=100m none /root
    mkdir /root/run /root/dev /root/proc /root/sys /root/tmp /root/root /root/etc /root/bin
    mkdir -p /root/nix/var/nix/profiles
    mkdir -p /root/nix/store
    echo 'root:x:0:0:root:/root:/run/current-system/sw/bin/bash' > /root/etc/passwd
    echo 'root:x:0:'  >  /root/etc/group
    echo 'kvm:x:106:' >> /root/etc/group
    echo 'tty:x:107:' >> /root/etc/group
    echo 'uucp:x:108:' >> /root/etc/group
    echo 'disk:x:109:' >> /root/etc/group
    echo 'audio:x:110:' >> /root/etc/group
    echo 'video:x:111:' >> /root/etc/group
    echo 'cdrom:x:112' >> /root/etc/group
    echo 'floppy:x:113' >> /root/etc/group
    echo 'input:x:114' >> /root/etc/group
    modprobe 9p
    modprobe 9pnet_virtio
    modprobe virtio_pci
    mount -t 9p -o trans=virtio,ro,msize=512000,version=9p2000.L nixstore /root/nix/store
  ''];
})]
