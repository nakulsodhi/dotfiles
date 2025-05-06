require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

})



function ApplyColor(color)
	color = color or "modus"
	vim.cmd.colorscheme(color)

    if vim.g.neovide then
        vim.g.neovide_theme = color
    end

--	vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
--	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })

    
end
ApplyColor("modus")


