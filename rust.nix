{
  lib,
  pkgs,
  rustc,
  cargo,
  clippy,
  rustfmt,
  cargo-insta,
  withInsta ? false,
}:
pkgs.mkShell {
  packages = [rustc cargo clippy rustfmt] ++ (lib.optional withInsta cargo-insta);
}
