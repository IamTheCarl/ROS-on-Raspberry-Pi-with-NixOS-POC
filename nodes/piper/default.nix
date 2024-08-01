{ pkgs ? import <nixpkgs> {} }:
pkgs.rosPackages.humble.buildRosPackage {
  pname = "piper";
  version = "0.1.0";
  src = ./.;

  buildType = "ament_python";

  # Nix packages to be provided in the runtime environment.
  propagatedBuildInputs = [
    pkgs.piper-tts
    pkgs.alsa-utils
    (import ./voice_models/en_US-hfc_male-medium/default.nix { pkgs=pkgs; })
    (pkgs.python3.withPackages (
      python-pkgs: []
    ))
    (import ../piper_interface/default.nix { pkgs=pkgs; })
  ];

  meta = {
    description = "Provides service to play audio with piper";
  };
}
