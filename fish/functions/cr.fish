function cr
    sudo ln -sf $HOME/.colima/default/docker.sock /var/run/docker.sock
    colima start --arch aarch64 --vm-type=vz --vz-rosetta --network-address
end
