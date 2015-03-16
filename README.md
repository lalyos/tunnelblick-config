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
# Configuration

This tool can install your openVpn configuration. The only required configuration
is the AWS s3 url of the tar gzipped tlbk directory.

```
export VPN_S3_URL=s3://mybucket/myconnection.tblk.tgz
```

# tl;dr

for Tunnelblick a connectio/configuration is nothing else just a directory with `*.tlbk` extension.
The are stored in `/Library/Application\ Support/Tunnelblick/Shared/`

The directory structure shoud be the following:
```
/Library/Application Support/Tunnelblick/Shared/myconnection.tblk
└── Contents
    └── Resources
        └── config.ovpn
```

Please note that the actual `*.ovpn` file **must be named as: config.ovpn**

