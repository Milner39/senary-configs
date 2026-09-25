{
  inputs = {

    senaryos = {
      url    =  "github:Milner39/senary-os";
      flake  =  false;
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
  } @ inputs: let

    senary = import senaryos;

  in {
    senaryosConfigurations = {

      # nix run --impure ./senary-configs/flakes/system/wl_vm-sen-fm#senaryosConfigurations.default
      default = (senary {
        nixpkgs-path  =  nixpkgs;
        site-dir      =  ./src;
      }).host.default.configuration.vm;

    };
  };
}
