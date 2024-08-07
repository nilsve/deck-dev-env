# podman build . -t devenv

# podman build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t devenv .

podman build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) --build-arg USERNAME=$(whoami) -t devenv .

# Allow X11 session

xhost +local:

# Run container with home mount and tty shell

podman run -it --rm \
  --userns=keep-id \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME:/home/$(whoami) \
  -e HOME=/home/$(whoami) \
  -v /nix:/nix \
  -e DISPLAY=$DISPLAY \
  --net=host \
  devenv \
  /bin/bash
