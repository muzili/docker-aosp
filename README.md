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
docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD:/aosp -v $PWD/ccache:/ccache muzili/aosp /bin/bash
```

or add it to your Dockerfile:

```
FROM muzili/aosp
```

## Note ##
* Due to the different uid/username between the docker and host environment, it is possible the create a normal user matched with the host uid, so the docker has to use root permission. The side effect is the generated files owner is root, there's some inconvenience if both docker and host to build or edit.
