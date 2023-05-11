function dgo
    [ count $argv -ne 0 ]; or echo "No args" && return 1
    set -l container $(dps -a $argv)
    if [ -z "$container" ]
        set -l container $(docker ps -aq --filter "id=$argv")
    end
    if [ -z "$container" ]
        echo "No such container" && return 1
    end
    if [ count $container -gt 1 ]
        echo "Ambigious query" && return 1
    end
end
