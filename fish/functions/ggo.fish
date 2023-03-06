function ggo
    git branch | fzf | xargs git checkout
end
