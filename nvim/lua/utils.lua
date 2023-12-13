local fn = vim.fn

local M = {}

function M.executable(name)
    if fn.executable(name) > 0 then
        return true
    end

    return false
end

function M.mkdir(dir)
    local res = fn.isdirectory(dir)

    if res == 0 then
        fn.mkdir(dir, "p")
    end
end

return M
