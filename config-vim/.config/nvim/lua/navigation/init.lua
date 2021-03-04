function NavigationFloatingWin(cmd)
    -- get the editor's max width and height
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    -- create a new, scratch buffer, for fzf
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

    -- if the editor is big enough
    local win_width
    local win_height
    if (height > 35) then
        win_height = math.min(math.ceil(height * 3 / 4), 30)
    else
        win_height = math.ceil(height - 2)
    end

    if (width > 150) then
        win_width = 130
        -- win_width = math.ceil(width * 0.9)
    else
        -- just subtract 8 from the editor's width
        win_width = math.ceil(width - 8)
    end

    -- settings for the fzf window
    local opts = {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = math.ceil((height - win_height) / 2),
        col = math.ceil((width - win_width) / 2)
    }

    -- create a new floating window, centered in the editor
    vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_win_set_option(0, "winblend", 20)

    if cmd then
        -- vim.cmd("call termopen(cmd, {'on_exit': {job_id, code, event-> luaeval("require('lazygit').on_exit(" . job_id . "," . code . "," . event . ")")}})")
        vim.api.nvim_command("term " .. cmd)
        vim.api.nvim_command("startinsert")
    end
end
