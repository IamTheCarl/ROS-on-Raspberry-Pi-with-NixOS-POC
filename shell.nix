# Environment containing basic ROS2 tools

{ pkgs ? import <nixpkgs> {} }:
let
  ros = import ./ros.nix {};
in
ros.pkgs.mkShell {
  nativeBuildInputs = [
    (import ./environment.nix {})
  ];
}
