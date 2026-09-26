{
  lib,
  infuse,
  sixos,
  senaryos,
  nixpkgs,
  nixpkgs-unstable,
  ...
}:

host: host-prev:

let

  senaryos-overlays = import "${senaryos}/pkgs/overlays.nix" { 
    inherit lib infuse;
  };


  # Instantiate a nixpkgs source for this host, with senaryos's package overlays
  pkgs-for = src: import src {
    localSystem = host.canonical;
    overlays = senaryos-overlays;
  };

  pkgs-stable    =  pkgs-for nixpkgs;
  pkgs-unstable  =  pkgs-for nixpkgs-unstable;

in infuse host-prev {

  canonical.__assign = sixos.lib.canonicalize builtins.currentSystem;


  pkgs.__assign = pkgs-stable;
  sw.__assign = host.pkgs.busybox;



  tags.dont-mount-root.__assign = true;
  tags.is-qemu-vm.__assign = true;


  boot.kernel.console.device.__init = "ttyS0";
  boot.kernel.console.baud.__init = 115200;

  boot.initrd.ttys.ttyS0.__init = 115200;

  boot.kernel.params.__append = [ "console=ttyS0,115200n8" ];


  targets.dnscache.__assign    =  host.six.mkBundle { };
  targets.nix-daemon.__assign  =  host.services.nix-daemon { package = host.pkgs.nix; };

}
