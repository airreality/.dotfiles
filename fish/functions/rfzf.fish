function rfzf
    yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro yay -Rns
end
