function vrg
    set -l search_results (rg -n "$argv" | string split \n)
    if [ -z "$search_results" ]
        echo "No results"
        return
    end
    set -l file (echo $search_results[1] | cut -d ':' -f 1)
    set -l line_number (echo $search_results[1] | cut -d ':' -f 2)

    nvim "$file" +$line_number
end
