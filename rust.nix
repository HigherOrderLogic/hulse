{
  lib,
  mkShell,
  stdenv,
  rust-overlay,
  rustc,
  cargo,
  clippy,
  cargo-insta,
  pkg-config,
  libxkbcommon,
  withInsta ? false,
  withWayland ? false,
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

  nativeBuildInputs = lib.optional withWayland pkg-config;

  buildInputs = lib.optional withWayland libxkbcommon;
}
