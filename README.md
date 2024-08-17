
# ROS on Raspberry Pi with NixOS (Proof of Concept)

Derived from PinPox's [Raspberry Pi SD image generator](https://github.com/pinpox/nixos-raspi4-template), this repository is a proof of concept for using Nix as a full devops solution for ROS.

This repository proves that three things can be done with Nix:
* You can get a ROS development environment on your development machine
* You can cross compile nodes for an ARM system
* You can generate an SD card image for easy bringup of robots
* You can update live robots over ssh for quick and easy updates

## Dependencies

You need to install [Nix](https://nix.dev/). To cross compile for ARM, you will need QEMU userspace emulation.
NixOS has [documentation](https://nixos.wiki/wiki/NixOS_on_ARM#Compiling_through_binfmt_QEMU) on how to do that.
Debian [has its own approach](https://wiki.debian.org/QemuUserEmulation).

## Commands

### nix-shell
You can get a development environment by running `nix-shell development.nix`. This will include everything you need to build and run ROS nodes.
You can also run `nix-shell shell.nix`, which will give you a minimal shell similar to what the robot will have. It only includes what you need to run nodes.

### ./build_image.sh
Generates an SD card image for a Raspberry Pi. The image will be available under `./result` once the build is complete. At that point you can decompress the image and write it to an SD card with something like `zstd -vdcfT6 /nix/store/...-aarch64-linux.img/sd-image/...-aarch64-linux.img.zst  | dd of=/dev/sdX status=progress bs=64K`. I suggest you look at [PinPox's Raspberry Pi SD image generator](https://github.com/pinpox/nixos-raspi4-template) since that's where this whole process was derived from.

### ./deploy_test.sh and ./deploy_switch.sh

Both of these scripts will take the current state of your repository, build it, and then deploy it to your raspberry pi. The key difference between deploy_test and deploy_switch is that the test variant will not permanently change the robot. Rebooting will revert it back to whatever state the OS was in before you deployed. Deploy switch will make the change persistent between reboots.
