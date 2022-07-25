function _get_git_branch_name
    git branch --show-current 2>/dev/null
end

function _has_unstaged_files
    git diff-files --quiet --ignore-submodules 2>/dev/null
    return (test $status -ne 0)
end

function _has_untracked_files
    set -l diff (git ls-files --other --exclude-standard 2>/dev/null)
    return (test -n "$diff")
end

function _get_git_status_indicator
    set -l indicator
    if _has_unstaged_files
        set -a indicator ✚
    end
    if _has_untracked_files
        set -a indicator •
    end
    if [ -z "$indicator" ]
        echo -n -s (set_color green) ✔ (set_color normal)
    else
        echo -n -s (set_color red) (string join '' $indicator) (set_color normal)
    end
end

function _get_git_branch_with_status
    set -l branch (_get_git_branch_name)
    if [ -z "$branch" ]
        return
    end
    echo -n -s $branch " " (_get_git_status_indicator)
end

function fish_right_prompt
    echo -n -s (set_color $fish_color_cwd) (_get_git_branch_with_status)
end

set async_prompt_functions _git_branch_name
set async_prompt_functions _get_git_status_indicator
