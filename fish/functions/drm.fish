function drm
    set -l container (dcheck $argv)
    or begin
        echo $container
        return 1
    end
    docker stop $container; or return 1
    docker rm $container; or return 1
end
