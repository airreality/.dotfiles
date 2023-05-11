function dps
    set -l args
    set -l filter
    set -l arg

    for arg in $argv
        if echo -- $arg | string match -qr "^--?.+\$"
            set -a -- args $arg
        else
            set -a -- filter $arg
        end
    end

    set filter (string join -- ".*" $filter)

    if [ -z "$filter" ]
        docker ps $args --format="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
    else
        docker ps $args -q --filter "name=$filter"
    end
end
