### AOSP environment for ubuntu 14.04.01 LTS

## Build ##
```
docker build -t muzili/aosp .
```
## Install ##

You can either pull from `muzili/aosp`:

```
docker pull muzili/aosp
```

```
docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD/aosp:/aosp -v $PWD/ccache:/ccache -u $UID:$GID muzili/aosp /bin/bash
```

or add it to your Dockerfile:

```
FROM muzili/aosp
```
