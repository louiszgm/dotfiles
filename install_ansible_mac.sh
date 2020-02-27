function installpip {
    pip install virtualenv 
}

function createEnv {
    python3 -m virtualenv $VIRTUALEVN_ROOT/ansible
    $VIRTUALEVN_ROOT/ansible/bin/activate
    pip install ansible
    pip install requests
    pip install urllib3
}