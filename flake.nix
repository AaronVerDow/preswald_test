{
  description = "Development environment for Python package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        websockets_10 = pkgs.callPackage ./websockets_10.nix { };
        preswald = pkgs.callPackage ./preswald.nix { websockets_10=websockets_10; };
        
        pythonEnv = pkgs.python3.withPackages (ps: [
          preswald
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pythonEnv
          ];
          
          shellHook = ''
            export PYTHONPATH = "${pythonEnv}/${pythonEnv.sitePackages}";
          '';
        };
      }
    );
}
