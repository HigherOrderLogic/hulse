{
  lib,
  pkgs,
  rust-overlay,
  rustc,
  cargo,
  clippy,
  cargo-insta,
  withInsta ? false,
}:
pkgs.mkShell {
  packages =
    [
      rustc
      cargo
      clippy
      rust-overlay.packages.${pkgs.stdenv.hostPlatform.system}.rust-nightly.availableComponents.rustfmt
    ]
    ++ (lib.optional withInsta cargo-insta);
}
