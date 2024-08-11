{}:
# import <nixpkgs> {
#   overlays = [
    (import (fetchTarball "https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz") {
      overlays = [
        (import (fetchTarball https://github.com/hacker1024/nix-ros-workspace/archive/master.tar.gz) {}).overlay
      ];
    })
#   ];
# }
# ros_workspace = import (fetchTarball https://github.com/hacker1024/nix-ros-workspace/archive/master.tar.gz) {};
# import (fetchTarball "https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz") {}
