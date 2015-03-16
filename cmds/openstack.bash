init(){
    deps-require aws

    cmd-export vpn-config
}

vpn-config() {
    declare desc="Installs TunnelBlick with a connection/profile with config.ovpn"

    check-tunnelblick
    download-connection
    start-tunnelblick
}

start-tunnelblick() {

    ( cat << "EOF"
===========================================================================
you might get a warnig about:

  THIS COPY OF TUNNELBLICK HAS BEEN TAMPERED ...

just fix it by entering your password
===========================================================================
EOF
    ) | yellow

    open /Applications/Tunnelblick.app

    echo '-----> [SUCCES] Now you can connect to any vpn in the context menu of the small tunnel icon top-right' | green
}

download-connection() {
    env-import VPN_S3_URL
    env-import AWS_ACCESS_KEY_ID
    env-import AWS_SECRET_ACCESS_KEY

    local connectionDir="/Library/Application Support/Tunnelblick/Shared/"
    sudo mkdir -p "$connectionDir"
    aws s3 cp $VPN_S3_URL /tmp/
    sudo tar -xzf /tmp/openstack.tblk.tgz -C "$connectionDir"
}

check-tunnelblick() {

    check-tunnelblick-in-user-apps
    
    if [ ! -e /Applications/Tunnelblick.app/ ]; then
        echo "-----> Tunnelblick is missing: install via brew cask: ..." | yellow
        install-tunnelblick
    fi
    if [ ! -e /Applications/Tunnelblick.app/ ]; then
       ( cat << "EOF"
===========================================================================
Tunelblick is missinng, installation failed, please try:

    brew cask install tunnelblick --appdir=/Applications --force
    
===========================================================================
EOF
        ) | red
        exit 14
    fi

    if [ -L /Applications/Tunnelblick.app ]; then
        echo "-----> Tunnelblick is installed into /Applications/, but its a symlink. Fixing it: ... " | yellow
        local origApp=$(readlink /Applications/Tunnelblick.app)
        sudo rm /Applications/Tunnelblick.app
        sudo cp -r $origApp /Applications/
    fi
}

check-tunnelblick-in-user-apps() {
    if [ -e ~/Applications/Tunnelblick.app ]; then
       ( cat << "EOF"
===========================================================================
You have installed Tunnelblick into ~/Applications instead of /Application
Please remove it first, by:
  rm -rf ~/Applications/Tunnelblick.app
It wont delete your connections/configurations
===========================================================================
EOF
        ) | red
        exit 11
    fi
}

check-brew() {
    if ! brew --version &> /dev/null; then
        (cat << "EOF"
===========================================================================
brew is missing, please install it by:

        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        
===========================================================================
EOF
        ) | red
        exit 12
    fi
}

check-brew-cask() {
    if ! brew cask --version &> /dev/null; then
        echo "-----> brew cask is missing: installing ..." | yellow
        brew install caskroom/cask/brew-cask
    fi

    if ! brew cask --version &> /dev/null; then
        (cat << "EOF"
===========================================================================
brew cask is missing, installation failed, please try to install it:

     brew install caskroom/cask/brew-cask
     
===========================================================================
EOF
        ) | red
        exit 13
    fi
}

install-tunnelblick() {
    check-brew
    check-brew-cask

    brew cask install tunnelblick --appdir=/Applications --force
}
