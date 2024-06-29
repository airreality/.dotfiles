function cfd
    set -l search_results (fd --type directory "$argv" | string split \n)
    if [ -z "$search_results" ]
        echo "No results"
        return
    end
    cd "$search_results[1]"
end
