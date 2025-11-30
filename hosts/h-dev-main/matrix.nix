{ inputs, ... }:

{
  #imports = [
  #  inputs.core.nixosModules.matrix-synapse
  #  ./element-call.nix
  #];
  imports = [ ../../modules/nixos/matrix-synapse ];

  services.matrix-synapse = {
    enable = true;
    dataDir = "/data/matrix-synapse";
  };

  #services.livekit.apiKey = "API5KrYmk3nGL7V";

}
