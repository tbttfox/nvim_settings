local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "airblade/vim-rooter",
        config = function()
            vim.g.rooter_silent_chdir = 1
            -- vim.g.rooter_targets = '*.py,*.c,*.cpp,*.h,*.cc,*.hpp'
            vim.g.rooter_patterns = {'.git', 'Makefile', '*.sln', 'build/env.sh'}
        end,
    })
end
return ret
