function fish_prompt --description 'Write out the prompt'
    set -l normal (set_color normal)
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    echo -n -s (set_color $color_cwd) (pwd) $normal " " $suffix " "
end
