{ pkgs ? import <nixpkgs> {} }:
(pkgs.rosPackages.humble.buildEnv {
  paths = [
    pkgs.rosPackages.humble.ros-core
    (import ./nodes/piper { pkgs = pkgs; })
  ];
})
