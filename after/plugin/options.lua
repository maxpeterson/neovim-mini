local opt = vim.opt

opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.hidden = true
opt.hlsearch = false
opt.ignorecase = true
opt.laststatus = 3
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.undofile = true
opt.updatetime = 250
opt.laststatus = 3
opt.cmdheight = 0
opt.expandtab = true

opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.showtabline = 2
opt.spell = true
opt.backupdir = './_backup,/tmp,.'

opt.path:remove("/usr/include")
opt.path:append("**")
opt.wildignorecase = true
opt.wildignore:append("**/node_modules/*")
opt.wildignore:append("**/.git/*")
opt.wildignore:append "*.swp"
opt.wildignore:append "*.bak"
opt.wildignore:append ".pyc"
opt.wildignore:append "*.class"
opt.wildignore:append ".jar"
opt.wildignore:append "*.gif"
opt.wildignore:append "*.png"
opt.wildignore:append "*.jpg"
opt.wildignore:append "*.dcm"
