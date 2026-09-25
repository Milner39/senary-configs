{
  inputs = {

    senaryos = {
      url = "github:milner39/senary-os";
      flake = false;
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

    senaryos = import senaryos;

  in {
    senaryosConfigurations = {

      # nix run --impure ./senary-configs/flakes/system/wl_vm-sen-fm#senaryosConfigurations.default
      default = {
      };

    };
  };
}
