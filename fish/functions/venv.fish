function venv
    source venv/bin/activate.fish >/dev/null 2>&1 && return
    source env/bin/activate.fish >/dev/null 2>&1 && return
    echo "No env. Create?"
    read create
    if [ "$create" = "y" ]
        python3 -m venv venv
        venv
    end
end
