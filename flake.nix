{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    ...
  }: let
    inherit (nixpkgs) lib;

    forEachSystem = fn: lib.genAttrs lib.systems.flakeExposed (system: fn system nixpkgs.legacyPackages.${system});
  in {
    formatter = forEachSystem (system: pkgs:
      pkgs.writeShellApplication {
        name = "aljd";
        runtimeInputs = with pkgs; [alejandra fd];
        text = ''
          fd "$@" -t f -e nix -X alejandra -q '{}'
        '';
      });

    devShells = forEachSystem (system: pkgs: let
      mkRustShell = extra: pkgs.callPackage ./rust.nix ({inherit rust-overlay;} // extra);
    in {
      rust = mkRustShell {};
      rust-w-insta = mkRustShell {withInsta = true;};
      rust-w-wayland = mkRustShell {withWayland = true;};
    });
  };
}
