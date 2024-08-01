{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  pname = "en_US-hfc_male-medium";
  version = "1.0.0";
  src = ./.;
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/voice_models
    cp -dR en_US-hfc_male-medium.onnx $out/share/voice_models
    cp -dR en_US-hfc_male-medium.onnx.json $out/share/voice_models
 
    runHook postInstall
   '';

  meta = with pkgs.lib; {
    description = "HFC male voice model for Piper";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
