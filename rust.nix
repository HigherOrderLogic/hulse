{
  mkShell,
  stdenv,
  rust-overlay,
  rustc,
  cargo,
  clippy,
}:
mkShell {
  packages = builtins.attrValues {
    inherit rustc cargo clippy;
    inherit (rust-overlay.packages.${stdenv.hostPlatform.system}.rust-nightly.availableComponents) rustfmt;
  };
}
