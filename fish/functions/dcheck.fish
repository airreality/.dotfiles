function dcheck
    if not count $argv >/dev/null
        echo "No args"
        return 1
    end
    set -l container $(dps -a $argv)
    if [ -z "$container" ]
        set container $(docker ps -aq --filter "id=$argv")
    end
    if [ -z "$container" ]
        echo "No such container"
        return 1
    end
    if [ (count $container) -gt 1 ]
        echo "Ambigious query"
        return 1
    end
    echo $container
end
