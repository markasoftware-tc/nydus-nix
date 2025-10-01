{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = {self, nixpkgs}:
    let supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
        eachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f system nixpkgs.legacyPackages.${system});
    in {
      packages = eachSupportedSystem (system: pkgs: rec {
        nydus = pkgs.callPackage (import ./nydus.nix) {};
        nydusify = pkgs.callPackage (import ./nydusify.nix) { inherit nydus; };
        nydus-snapshotter = pkgs.callPackage (import ./nydus-snapshotter.nix) { inherit nydus; };
      });

      apps = eachSupportedSystem (system: pkgs: {
        nydus-image = { type = "app"; program = "${self.packages.${system}.nydus}/bin/nydus-image"; };
        nydusd = { type = "app"; program = "${self.packages.${system}.nydus}/bin/nydusd"; };
        nydusctl = { type = "app"; program = "${self.packages.${system}.nydus}/bin/nydusctl"; };
        containerd-nydus-grpc = { type = "app"; program = "${self.packages.${system}.nydus-snapshotter}/bin/containerd-nydus-grpc"; };
      });

      devShells = eachSupportedSystem (system: pkgs: {
        default = pkgs.mkShell {
          inputsFrom = builtins.attrValues self.packages.${system};
          nativeBuildInputs = [ pkgs.rust-analyzer pkgs.gopls pkgs.clippy pkgs.rustfmt ];
        };
      });
    };
}
