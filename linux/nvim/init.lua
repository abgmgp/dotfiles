vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  { 
    "ellisonleao/gruvbox.nvim", 
    priority = 1000, 
    config = true, 
    opts = ...
  },
  {
    "folke/twilight.nvim",
    opts = {}
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
})

require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  },
  extensions = {
    file_browser = { 
      hijack_netrw = true,
      hidden = { file_browser = true, folder_browser = true },
      display_stat = false,
    },
  },
}

vim.cmd("set shortmess+=I")
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.keymap.set("n", "<leader>e", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>t", ":Twilight<CR>")
vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function() vim.cmd("Twilight") end,
})