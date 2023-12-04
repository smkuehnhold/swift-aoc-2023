{ mkShell, swiftImage, ... }:

let
  swiftImageFullname = "localhost/${swiftImage.imageName}:${swiftImage.imageTag}";
in mkShell {
  # TODO: inputsFrom = [ podman ] ??
  # TODO: not sure where localhost comes from in the name
  # TODO: is there a better way to setup the volume???
  shellHook = ''
    # Load image into podman (if image doesn't already exist)
    podman image exists ${swiftImageFullname}
    IMAGE_STATUS=$?
    if test $IMAGE_STATUS -eq 1; then
        podman load < "${swiftImage}" 1>/dev/null 2>&1
    fi

    # Because sometimes you want to exit and then enter back
    alias enter-dev-env="podman run -it -v \$(pwd):/mnt ${swiftImageFullname}"

    # Enter the environment
    enter-dev-env
    '';
}