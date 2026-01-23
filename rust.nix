{
  lib,
  mkShell,
  stdenv,
  rust-overlay,
  rustc,
  cargo,
  clippy,
  cargo-insta,
  withInsta ? false,
}:
mkShell {
  packages =
    [
      rustc
      cargo
      clippy
      rust-overlay.packages.${stdenv.hostPlatform.system}.rust-nightly.availableComponents.rustfmt
    ]
    ++ (lib.optional withInsta cargo-insta);
}
