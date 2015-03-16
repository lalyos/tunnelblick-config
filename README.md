This is a tool to help you to set up openvpn an connection on OSX

It is using the OSX wrapper of openvpn called [Tunnelblick](https://code.google.com/p/tunnelblick/)


# Installation

This tool uses [glidergun](https://github.com/gliderlabs/glidergun) under the hood. So you can install it via:

```
curl https://dl.gliderlabs.com/glidergun/latest/$(uname -sm|tr \  _).tgz \
    | tar -zxC /usr/local/bin
```

```
git clone git@github.com:sequenceiq/tunnelblick-config.git
cd tunnelblick-config
gun vpn-config
```

