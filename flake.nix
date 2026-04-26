{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }: 
  let
    system = "x86_64-linux";
    unstable = import nixpkgs-unstable { inherit system; config.allowunfree = true; };
  in {
    nixosconfigurations.mostafa = nixpkgs.lib.nixossystem {
      inherit system;
      modules = [
        ./configuration.nix
        {
          _module.args.unstable = unstable;
        }
      ];
    };
  };
}
