{}:
let
  pkgs = import ./ros.nix {};
in
(pkgs.rosPackages.humble.buildROSWorkspace  {
  name = "autonomy";
  devPackages = {
    inherit
      (import ./nodes/piper {});
  };
  prebuiltPackages = {
    inherit
      (pkgs.rosPackages.humble.ros-core);
  };
})
