{ pkgs ? import <nixpkgs> {} }:
pkgs.rosPackages.humble.buildRosPackage {
  pname = "piper_interface";
  version = "0.1.0";
  src = ./.;

  buildType = "ament_cmake";
  buildInputs = [ pkgs.rosPackages.humble.ament-cmake pkgs.rosPackages.humble.rosidl-default-generators ];
  propagatedBuildInputs = [ pkgs.rosPackages.humble.rosidl-default-runtime ];
  nativeBuildInputs = [ pkgs.rosPackages.humble.ament-cmake pkgs.rosPackages.humble.rosidl-default-generators ];

  meta = {
    description = "Provides messages and services for piper node";
  };
}
