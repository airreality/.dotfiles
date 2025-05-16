function vfd
    set -l search_results (fd "$argv" | string split \n)
    if [ -z "$search_results" ]
        echo "No results"
        return
    end

    nvim "$search_results[1]"
end
