{ lib, pkgs,  ... }:
let
  # Obtain ROS overlays
  ros = import (fetchTarball "https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz") { };
in
{
  system.stateVersion = "24.04";

  # Networking
  systemd.network.enable = true;
  networking.useNetworkd = true;
  networking.hostName = "rosetta";

  # SSH
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2HeInk61LesQA63NalxP7quBEUnKE8vA78vd0oCF/AbKCk4AyKHdT+TLgs/B5Klf7rD4vT1DcX1i2XMxoIVZCyGoqpItx9DLPI78LcGDPajjzWywO6wSa2C4yYyGfl5Xg+jQqnNZxCm+TrAAkJNJr5kgbIvnOd6tWdCHBNQubwcxY6Uk4xaxkVW4c9eCrmb066PnQ6vchuq6qo+OsBwaKudOQYp7nZ4Edosd2pKV51YXoRhBH9erFDVThUMLwgy8KIpkDx+betoJnHUfBTylKsXup56ylG0kvtAlDIkf+FHmiZBnqucd2ulmkRlKU23A9m6qnyVMEYZ/E6zHL+rVTwzeih0rQz7e4QU9fQoh2+/aXgJcMvJ93QfR02NaZ42rCMSS4yMOP9J2pcRQlugHwh2PoiPCpdt29htifVQaOiGx116QsSx/HZ4/Yvui7TcoujDsHcru8tn8Ad/PtXVVY1/ZLlmEh6EmKRkZP8MRETkNNmKkpH0N1bL0tR2LMpOc="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCWgJNhExXIzMcTbQlv2aU0Vv7mwA7plXak8v2G29PamSTPcKNNW7Gizn5K08DdXzlqosworu+wlQq+Y0HlQCWxrk/YcvJQjyGTPqOQRSRCB6Yv07Xx3TOJNxSm4vRgCsBWiTq0jL3xHOxWgfX+NdFGZv53VoCJExvy0SJEw+cxQL4LcBrW/np2vlGYpj1p2IXg8go4eV7goHV+T31fLS22vN8IQtY7QViTN+/f4k85eZVOLNJ6PEbBN9n6xCUPvW70laksFB9jX1jMMLKUGXUUJAH+ZU9ait+R/yLE7aXLUganmRL9EY/1KGir0kuAzwyVQa/nS5BS9oR5Ue9ycBNENrb2GTRc2HktjTa702+3y+xktvDinoZis4L0dkEY44HChWlIgiZlDI56y62n1opzOK9V4F0CCCRuL+iWypgNJFn6fEVxyMK8cA5p53H8Aazwv2k532l3U8bYy3+2lnh6LjsdcJu3tr0VuJ18fBl3WxaoMzqogIhvhrij5gaQIEM="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCQka6Wsqn6camxkHfk+bw+g0glqVHaZe/boMTFm3sUUQO81yJbn20hrX+Mi30l/DurjEkhfBenHL3KxwSM2bBaAWg01h41Xg1Ps8jjrxKlWK0hcrwvqjd2UcdTNYzB7uPNNeqY2AsOPYkh9kKWsI3j3M7PuJLKVUiIColv/FXV3MqKHENN2ETktlhKmBZgsr7iQSypVzMR/zVIgKTiJfsjjxoL+AnonnQ4f8tWGNqAOiio7UdrHUwyLMBlWNoRtTcIkyYnvDsYK4WT0LsZD2SouQHgP3q0LC9JWUjuJBHgV7RMFa1cz6bbDZR8jQ4ToWOrTB6XalJuhfp93u4bbMWipnUXxGqNPU6+nl+gQvaGMKoz1asGtcME5FCmh2cwmXiHEB9YhoI3wtFmgypwnOHDRKXvhN7q2PCF83j0OONJQyHKt6B4DlGbFFHbu4YOJBoB03+5yBlNqGMQyQ1B0d+y6lnUWmS0qpYkq4RaW8+9Djdag9AL4GmoUnWE/j/L1kE="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCeCLaOoyM9gz3v3hki8PnhEyxw89Sti3zAengqAn2+32Afhd7kUS0eXvQDplAuzUTK0yef2gdvQhMmIsQLPO0QAXSIjYumvOT/5RSRie6SPamidakCmyNu+sr5+YMd4yQFmMbzw6TkytyeJIHihshGD5N/RSjDyfczXnkXAJUuNv2UhdBUIAYudof0eRCPtW3XUoPWrGLPZITpflcWcZOjYDZNOOgCbX9v6eVfDwniU/y02ICd8/89OYG7izvi5xjY58RDoKy+t1UPVSJZk7vYYyZK/tB1y5APJg+uMDzB4oFBXImq7NAYoUqQttJcsKMtxVdArud7MyTyxzTFwfW5YmuK0pLyq+xW/mh72g6Cvx8OtEpUqWV7PV1Ahu8AoZ6L/MplSObZ7HLj6HLQC1RK+SrigT9lBLAkz8vX1sueQeNIgSdx4lv3jXkI668d7ylXJP1mvBFoEXRcAkuBQhOjYaLQCWx03GBa/n+GVBtbYpLnHDPSI7L3Vs+uz57vqj8="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfho5osxu8sQFfOLJoehHL2gNBmHoo8Wvc1wlg1VRHYnrE4REbAB+pB/GfYJkY3UCOw2xYoE9rCnYYYt1jbZ6T/VEEnHh4j4qGAT2OdB+2eH1il9OrfxSf9lvu+1Q6y0FSOO8uhKH5LY+I/6a0y8zKs9m20DybQOz8ntIcWnruxQMvq6dCuweKkeko6INvq6H8edYxlpCJQtk88VLtB+s9+f74JpUmsTEdbP8HY8uzqyZz505lZofBSg2uQKwFplg92hL2jQzQrWYYldbNhg0WYyQAf9Mk+9//lph5HaBUq2FUTVzdzvswK9WTniH5rUFbZJTHtvynXzf+jZFl5JybBWJ7xU2l6Kov9AlFe3C+RQ9IhAlgxajy57zwTNekm13S99L7P7ddtRcfF7knSWo7QbbpSw3q9/6PuA4vxr7KvbnT9PgUPJ7Rtu2/9Hf9Rm9hvKKr+HE3T2SdrzcdkSuANwiUfYCSgMmUCZi6ACKl1zSsXRg6eFpK5EyxC5hu1A8="
];


  # Install system packages.
  environment.systemPackages = [ 
    (ros.rosPackages.humble.buildEnv {
    name = "ros_env";
    paths = [
      pkgs.vim
      ros.rosPackages.humble.ros-core
      ros.rosPackages.humble.ros2cli
      ros.rosPackages.humble.ros2cli
      ros.pkgs.colcon
    ];
  })
  ];
}
