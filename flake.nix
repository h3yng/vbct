{
  description = "Go project template with a Nix dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            go
            gopls
            delve
            golangci-lint
            gofumpt

          ];

          shellHook = ''
            export GOPATH="$PWD/.gopath"
            export GOMODCACHE="$PWD/.gopath/pkg/mod"
            export GOCACHE="$PWD/.gocache"
            mkdir -p "$GOPATH" "$GOMODCACHE" "$GOCACHE"
          '';
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
