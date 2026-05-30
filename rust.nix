{
  mkShell,
  rustc,
  cargo,
  clippy,
  rustfmt,
}: let
  rustfmt' = rustfmt.override {asNightly = true;};
in
  mkShell {packages = [rustc cargo clippy rustfmt'];}
