-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
    desc = "Highlight on yank",
})


-- Load per-project settings
PPLoadedFiles = {}

local projectCfgGroup = vim.api.nvim_create_augroup("LocalProjectConfig", { clear = true })
vim.api.nvim_create_autocmd({"BufRead","BufNewFile","DirChanged"}, {
    pattern = "*",
    callback = function()
        local isWin = vim.loop.os_uname().sysname:find("Windows", 1, true) and true
        local slash = isWin and '\\' or '/'
        local pfile = table.concat({vim.fn.getcwd(), ".vim", "local.lua"}, slash)
        local ex = vim.loop.fs_stat(pfile)
        if not ex then
            return
        end

        -- Don't load the same file twice
        -- use the modified time tuple
        local ptime = PPLoadedFiles[pfile]
        if ptime then
            if ex['mtime'] == ptime then
                return
            end
        end

        dofile(pfile)
        PPLoadedFiles[pfile] = true
    end,
    desc = "Load .vim/local.lua per project",
    group = projectCfgGroup,
})

