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
  wayland,
  libGL,
  libxkbcommon,
  withInsta ? false,
  withWayland ? false,
  withSlint ? false,
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

  nativeBuildInputs = lib.optional (withWayland || withSlint) pkg-config;

  buildInputs = lib.optionals (withWayland || withSlint) [wayland libxkbcommon];

  env.RUSTFLAGS = lib.optionalString withSlint "-C link-arg=-Wl,-rpath,${lib.makeLibraryPath [wayland libGL]}";
}
