function dgo
    set -l container (dcheck $argv)
    or begin 
        echo $container
        return 1
    end
    dbash $container; or return 1
end
