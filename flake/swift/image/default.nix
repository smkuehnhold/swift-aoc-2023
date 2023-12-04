{ dockerTools, ... }:

let
  inherit (dockerTools) pullImage buildLayeredImage;

  baseImage = pullImage {
    imageName = "swift";
    imageDigest = "sha256:d1a20a7ca0272bc0313a443b313762e465bd657674e41fbd06a06740a389a84e";
    sha256 = "1kwsi98jgg8vmkr2y900hby9b7p77dyzwz9jh528hi4plljv3hmn";
    finalImageTag = "5.9.1";
  };
in buildLayeredImage {
  name = "swift-dev-env";
  fromImage = baseImage;
  config = {
    EntryPoint = [ "/usr/bin/env" "bash" ];
    WorkingDir = "/mnt";
    Volumes = { "/mnt" = { }; };
  };
}

