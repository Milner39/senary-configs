{
  inputs = {

    senaryos = {
      url    =  "github:Milner39/senary-os";
      inputs.nixpkgs.follows  =  "nixpkgs";
    };

    nixpkgs.url           =  "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url  =  "github:nixos/nixpkgs/nixos-unstable";

  };

  outputs = {
    self,
    senaryos,
    nixpkgs,
    nixpkgs-unstable,
    ...
  } @ inputs: {

    senaryosConfigurations = {

      # nix run --impure ./senary-configs/flakes/system/wl_vm-sen-fm#senaryosConfigurations.default
      # nix run --impure --override-input senaryos ./senary-os ./senary-configs/flakes/system/wl_vm-sen-fm#senaryosConfigurations.default
      default = (senaryos.lib.mkSite {
        nixpkgs-path  =  nixpkgs;
        site-dir      =  ./src;

        extra-auto-args = {
          # Kinda messy, going to fix this.
          # Caused by sixos not exposing it's overrides.
          inherit senaryos nixpkgs nixpkgs-unstable;
        };
      }).hosts.default.configuration.vm;

    };
  };
}
