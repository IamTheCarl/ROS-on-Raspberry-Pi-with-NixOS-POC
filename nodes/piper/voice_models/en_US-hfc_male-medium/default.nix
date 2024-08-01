{ pkgs ? import <nixpkgs> {} }:
pkgs.rosPackages.humble.buildRosPackage {
  pname = "en_US-hfc_male-medium";
  version = "1.0.0";
  src = ./.;

  buildType = "ament_cmake";
  buildInputs = [ pkgs.rosPackages.humble.ament-cmake ];

  # installPhase = ''
  #   mkdir -p $out/share/voice_models
  #   cp en_US-hfc_male-medium.onnx $out/share/voice_models
  #   cp en_US-hfc_male-medium.onnx.json $out/share/voice_models
  # '';

  meta = with pkgs.lib; {
    description = "HFC male voice model for Piper";
    platforms = platforms.all;
    license = licenses.mit;
  };
}
