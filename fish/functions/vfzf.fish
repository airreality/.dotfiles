function vfzf
    set -l file
    if [ $(count $argv) -ne 0 ]
        set file $(fzf -q "$argv")
    else
        set file $(fzf)
    end
    if [ -n "$file" ]
        nvim "$file"
    end
end
