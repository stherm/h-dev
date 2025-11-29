{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.nginx
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix
    ./packages.nix
  ];

  networking.hostName = "h-dev-main";

  services = {
    nginx.enable = true;
  };

  normalUsers = {
    steffen = {
      extraGroups = [
        "wheel"
      ];
      sshKeyFiles = [
        ../../users/steffen/pubkeys/L13G2.pub
        ../../users/steffen/pubkeys/X670E.pub
      ];
    };
  };

  system.stateVersion = "25.05";
}
