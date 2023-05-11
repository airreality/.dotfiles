function dbash
    docker exec -it $argv bash; or \
    if [ $status -eq 126 ]
        then docker exec -it $argv sh
    end
end
