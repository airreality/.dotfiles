local keymap = vim.keymap

-- save key strokes (do not press shift to enter command mode)
keymap.set({ "n", "x" }, ";", ":")

-- paste non-linewise text above or below current line
keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

keymap.set("n", "<leader>q", "<cmd>nohlsearch<cr>", { desc = "reset search highlighting" })

-- Navigation in the location and quickfix list
-- TODO
keymap.set("n", "[l", "<cmd>lprevious<cr>zv", { silent = true, desc = "previous location item" })
keymap.set("n", "]l", "<cmd>lnext<cr>zv", { silent = true, desc = "next location item" })

keymap.set("n", "[L", "<cmd>lfirst<cr>zv", { silent = true, desc = "first location item" })
keymap.set("n", "]L", "<cmd>llast<cr>zv", { silent = true, desc = "last location item" })

keymap.set("n", "[q", "<cmd>cprevious<cr>zv", { silent = true, desc = "previous qf item" })
keymap.set("n", "]q", "<cmd>cnext<cr>zv", { silent = true, desc = "next qf item" })

keymap.set("n", "[Q", "<cmd>cfirst<cr>zv", { silent = true, desc = "first qf item" })
keymap.set("n", "]Q", "<cmd>clast<cr>zv", { silent = true, desc = "last qf item" })

-- close location list or quickfix list if they are present
keymap.set("n", [[\x]], "<cmd>windo lclose <bar> cclose <cr>", {
    silent = true,
    desc = "close qf and location list",
})

-- delete a buffer, without closing the window
keymap.set("n", [[\d]], "<cmd>bprevious <bar> bdelete #<cr>", {
    silent = true,
    desc = "delete buffer",
})

-- insert a blank line below or above current line (do not move the cursor)
keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {
    expr = true,
    desc = "insert line below",
})

keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {
    expr = true,
    desc = "insert line above",
})

-- do not include white space characters when using $ in visual mode
keymap.set("x", "$", "g_")

keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")

keymap.set("n", "/", [[/\v]])

-- change current working directory locally and print cwd after that
keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", { desc = "change cwd" })

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- toggle spell checking
keymap.set("n", "<F11>", "<cmd>set spell!<cr>", { desc = "toggle spell" })
keymap.set("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "toggle spell" })

-- change text without putting it into the vim register
keymap.set("n", "c", '"_c')
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("x", "c", '"_c')

-- move current line up and down
keymap.set("n", "<A-k>", '<cmd>call utils#SwitchLine(line("."), "up")<cr>', { desc = "move line up" })
keymap.set("n", "<A-j>", '<cmd>call utils#SwitchLine(line("."), "down")<cr>', { desc = "move line down" })

-- move current visual-line selection up and down
keymap.set("x", "<A-k>", '<cmd>call utils#MoveSelection("up")<cr>', { desc = "move selection up" })
keymap.set("x", "<A-j>", '<cmd>call utils#MoveSelection("down")<cr>', { desc = "move selection down" })

-- replace visual selection with text in register, but not contaminate the register
keymap.set("x", "p", '"_c<Esc>p')

-- go to a certain buffer
keymap.set("n", "gb", '<cmd>call buf_utils#GoToBuffer(v:count, "forward")<cr>', {
    desc = "go to buffer (forward)",
})
keymap.set("n", "gB", '<cmd>call buf_utils#GoToBuffer(v:count, "backward")<cr>', {
    desc = "go to buffer (backward)",
})

-- switch windows
keymap.set("n", "<left>", "<c-w>h")
keymap.set("n", "<Right>", "<C-W>l")
keymap.set("n", "<Up>", "<C-W>k")
keymap.set("n", "<Down>", "<C-W>j")

-- break inserted text into smaller undo units when we insert some punctuation chars
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
    keymap.set("i", ch, ch .. "<c-g>u")
end

-- go to the beginning and end of current line in insert mode quickly
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")

-- go to beginning of command in command-line mode
keymap.set("c", "<C-A>", "<HOME>")

-- fzf
keymap.set("n", "<leader>s", "<cmd>FzfLua files<cr>")
keymap.set("n", "<leader>c", "<cmd>FzfLua buffers<cr>")
keymap.set("n", "<leader>a", "<cmd>FzfLua grep<cr><cr>")
keymap.set("n", "<leader>i", "<cmd>FzfLua git_status<cr>")

-- copilot
keymap.set("n", "<space>l", "<cmd>Copilot panel<cr>", { desc = "open copilot" })
keymap.set("n", "<space>h", "<cmd>CopilotChatToggle<cr>", { desc = "toggle copilot chat" })

-- yanky
vim.keymap.set("n", "<leader>y", "<cmd>YankyRingHistory<cr>", { desc = "Open yank history" })
