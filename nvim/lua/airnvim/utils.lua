local fn = vim.fn

local M = {}

function M.executable(name)
    if fn.executable(name) > 0 then
        return true
    end

    return false
end

function M.python_path()
    local venv_path = os.getenv("VIRTUAL_ENV")
    if venv_path ~= nil then
        return venv_path .. "/bin/python3"
    else
        return vim.g.python3_host_prog
    end
end

return M
