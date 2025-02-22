" vim: set fdm=marker fdl=0:

" ---- Fallback to Vim's configuration {{{1
" ----
let g:FallbackToVim = 0

if g:FallbackToVim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    source ~/.vimrc
    finish
endif
" }}}


" ---- Plugins {{{1
" ----
call plug#begin()
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'goolord/alpha-nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'fladson/vim-kitty'
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'hood/popui.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'ludovicchabant/vim-gutentags'
Plug 'cohama/lexima.vim'
Plug 'machakann/vim-sandwich'
Plug 'kshenoy/vim-signature'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'hedyhli/outline.nvim'
Plug 'epheien/outline-treesitter-provider.nvim'
Plug 'epheien/outline-ctags-provider.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'onsails/lspkind-nvim'
Plug 'lyokha/nvim-treesitter-context'
Plug 'haringsrob/nvim_context_vt'
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'rhysd/git-messenger.vim'
Plug 'rhysd/committia.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'psliwka/vim-smoothie', { 'commit': '10fd0aa' }
Plug 'danilamihailov/beacon.nvim', { 'commit': 'a786c9a' }
Plug 'bogado/file-line'
Plug 'uga-rosa/ccc.nvim'
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'dpelle/vim-LanguageTool'
Plug 'mechatroner/rainbow_csv'
Plug 'derekwyatt/vim-fswitch'
Plug 'dhruvasagar/vim-table-mode'
Plug 'neovimhaskell/haskell-vim'
Plug 'chr4/nginx.vim'
Plug 'lyokha/vim-xkbswitch'
Plug 'lyokha/vim-publish-helper'
Plug 'lyokha/vim-right-align'
Plug 'lyokha/vim-prev-indent'
call plug#end()
" }}}


" ---- Colorscheme {{{1
" ----
set termguicolors

" seamless FloatBorder around NormalFloat for gruvbox-material colorscheme
autocmd ColorScheme *
            \ highlight FloatBorder
            \     cterm=NONE ctermfg=186 ctermbg=237
            \     gui=NONE guifg=#d7d787 guibg=#45403d

let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_enable_italic = 1

colorscheme gruvbox-material

let g:CustomTSHighlights = 1

if g:CustomTSHighlights
    highlight TSFunction
                \ cterm=NONE ctermfg=192 ctermbg=NONE
                \ gui=NONE guifg=#c1d173 guibg=NONE
    highlight link TSFunctionCall TSFunction
    highlight TSVariable
                \ cterm=NONE ctermfg=49 ctermbg=NONE
                \ gui=NONE guifg=#00ee9e guibg=NONE
    highlight link TSParameter TSVariable
    highlight TSConstant
                \ cterm=NONE ctermfg=49 ctermbg=NONE
                \ gui=italic guifg=#00ee9e guibg=NONE
    highlight TSProperty
                \ cterm=NONE ctermfg=49 ctermbg=NONE
                \ gui=NONE guifg=#09d08d guibg=NONE
    highlight link TSField TSProperty
    highlight link @constructor.haskell TSProperty
    highlight link @keyword.quote.haskell haskellTH
endif

let g:CustomFoldedHighlights = 1

if g:CustomFoldedHighlights
    highlight Folded
                \ cterm=NONE ctermfg=NONE ctermbg=238
                \ gui=NONE guifg=NONE guibg=#332f2d
endif

highlight FoldAnno
            \ cterm=NONE ctermfg=79 ctermbg=NONE
            \ gui=NONE guifg=#3d8a70 guibg=NONE

let g:CustomMatchParenHighlight = 1

if g:CustomMatchParenHighlight
    highlight MatchParen
                \ cterm=bold ctermfg=122 ctermbg=NONE
                \ gui=bold guifg=#99ffcc guibg=NONE
endif
" }}}


" ---- Miscellaneous basic customizations {{{1
" ----
set nocompatible

set ruler
set showcmd

" let g:StaticTitleIcon = ""

" note that setting title causes glitches in terminals using ncurses 6.3,
" see https://github.com/neovim/neovim/issues/18573
set title
set titlestring=%{init#get_title_text()}%{%init#get_title_modified()%}
set titlelen=0

" always show statusline
set laststatus=2

set expandtab
set tabstop=8
set softtabstop=4
set smarttab
set shiftwidth=4
set shiftround
set nojoinspaces
set cindent
set scrolloff=0
set cinoptions=:0(0+2s
set completeopt=menu
set foldcolumn=0
set foldlevelstart=99
set listchars=tab:󰅂\ ,trail:·,nbsp:⍽
set list

set mouse=a
set hlsearch
set noincsearch

" make vertical split open on the right
set splitright

let mapleader = ','
let g:netrw_winsize = 25

let g:cursorhold_updatetime = 100

" editorconfig clashes with file_line()
let g:editorconfig = v:false
" }}}


" ---- System clipboard copy and paste {{{1
" ----
if !empty($DISPLAY) && executable('xclip')
    let g:clipboard = { 'name': 'xclip-preferred',
                      \ 'copy':
                      \     {'*': 'xclip -selection primary -r -quiet -i',
                      \      '+': 'xclip -selection clipboard -r -quiet -i'},
                      \ 'paste':
                      \     {'*': 'xclip -selection primary -o',
                      \      '+': 'xclip -selection clipboard -o'},
                      \ 'cache_enabled': 1 }
endif

" easy mappings for the primary (*) and the clipboard (+) selections
vmap <silent> <C-c> "*y:call setreg('+', getreg('*', 1))<CR>
nmap <silent> ,i    "*p
nmap <silent> ,I    "*P
nmap <silent> ,y    "+p
nmap <silent> ,Y    "+P
" }}}


" ---- Setup alpha-nvim and ccc {{{1
" ----
lua <<EOF
  local theta = require'alpha.themes.theta'
  local dashboard = require'alpha.themes.dashboard'

  theta.buttons.val = {
    { type = "text", val = "Quick links",
      opts = { hl = "SpecialComment", position = "center" }
    },
    { type = "padding", val = 1 },
    dashboard.button("e", "󰈔  New file", "<cmd>enew<CR>"),
    dashboard.button("CTRL-p p", "󰈞  Find file",
                     "<cmd>Telescope find_files<CR>"),
    dashboard.button("CTRL-P g", "󰊄  Live grep",
                     "<cmd>Telescope live_grep<CR>"),
    dashboard.button("c", "  Configuration",
                     "<cmd>e ~/.config/nvim/init.vim<CR>"),
    dashboard.button("u", "󰚰  Update plugins", "<cmd>PlugUpdate<CR>"),
    dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
    { type = "padding", val = 2 },
    { type = "text", val = "File browser",
      opts = { hl = "SpecialComment", position = "center" }
    },
    { type = "padding", val = 1 },
    dashboard.button("CTRL-p f", "󰉓  File browser",
                     "<cmd>Telescope file_browser<CR>")
  }

  require'alpha'.setup(theta.config)

  require'ccc'.setup { lsp = false }
EOF
" }}}


" ---- Setup telescope {{{1
" ----

" after loading markdown/pandoc files with telescope, expected folds won't
" trigger (see https://github.com/nvim-telescope/telescope.nvim/issues/559);
" one of proposed workarounds is leaving insert mode before exiting telescope

lua <<EOF
  local function stopinsert(callback)
    return function(prompt_bufnr)
      vim.cmd.stopinsert()
      vim.schedule(function() callback(prompt_bufnr) end)
    end
  end

  local function stopinsert_fb(callback, callback_dir)
    return function(prompt_bufnr)
      local entry = require'telescope.actions.state'.get_selected_entry()
      if entry then
        if not entry.Path:is_dir() then
          stopinsert(callback)(prompt_bufnr)
        elseif callback_dir then
          callback_dir(prompt_bufnr)
        end
      end
    end
  end

  local actions = require'telescope.actions'
  local actions_fb = require'telescope'.extensions.file_browser.actions

  require'telescope'.setup {
    defaults = {
      mappings = {
        i = {
          ["<CR>"]  = stopinsert(actions.select_default),
          ["<C-x>"] = stopinsert(actions.select_horizontal),
          ["<C-j>"] = stopinsert(actions.select_vertical),
          ["<C-t>"] = stopinsert(actions.select_tab)
        }
      }
    },
    extensions = {
      file_browser = {
        mappings = {
          i = {
            ["<CR>"]  = stopinsert_fb(actions.select_default,
                                      actions.select_default),
            ["<C-x>"] = stopinsert_fb(actions.select_horizontal),
            ["<C-j>"] = stopinsert_fb(actions.select_vertical),
            ["<C-t>"] = stopinsert_fb(actions.select_tab,
                                      actions_fb.change_cwd)
          }
        }
      }
    }
  }

  require'telescope'.load_extension 'file_browser'
EOF
" }}}


" ---- Setup nvim-web-devicons {{{1
" ----
lua <<EOF
  local devicons = require'nvim-web-devicons'

  devicons.set_icon {
    nginx = { icon = '', color = '#009400', cterm_color = '28',
      name = 'Nginx'
    },
    shellsession = { icon = '', color = '#cbcb41', cterm_color = '185',
      name = 'ShellSession'
    }
  }

  devicons.set_icon_by_filetype {
    latex = 'tex', nginx = 'nginx', shellsession = 'shellsession',
    shelloutput = 'shellsession'
  }
EOF
" }}}


" ---- Setup treesitter {{{1
" ----
lua <<EOF
  local query = require'vim.treesitter.query'
  local devicons = require'nvim-web-devicons'

  -- Conceal language injections by language icons from devicons
  query.add_directive('set-conceal-from-info-string!',
    function(match, _, bufnr, pred, metadata)
      local capture_id = pred[2]
      local node = match[capture_id]
      if not node then
        return
      end
      local lang = vim.treesitter.get_node_text(node, bufnr):lower()
      -- Pandoc attribute style requires a dot before the language id
      if lang:sub(1, 1) == '.' then
        lang = lang:sub(2)
      end
      metadata.conceal = devicons.get_icon_by_filetype(lang) or ''
    end, opts)

  -- Register filetype pandoc as language markdown
  vim.treesitter.language.register('markdown', 'pandoc')

  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'bash', 'c', 'cmake', 'cpp', 'doxygen', 'go', 'gomod', 'haskell',
      'json', 'latex', 'lua', 'make', 'markdown', 'nginx', 'perl', 'python',
      'r', 'rst', 'rust', 'toml', 'vim', 'vimdoc', 'xml', 'yaml'
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'haskell' },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "sn",
        node_incremental = "n",
        scope_incremental = "N",
        node_decremental = "m",
      }
    }
  }
EOF
" }}}


" ---- Setup language servers and related stuff {{{1
" ----
lua <<EOF
  local nvim_lsp = require'lspconfig'

  require'lspkind'.init()

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Uncomment the next line to disable LSP semantic tokens highlights
    -- client.server_capabilities.semanticTokensProvider = nil

    -- Use LSP as the handler for omnifunc
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Use LSP as the handler for formatexpr
    buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')

    -- Mappings
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD',
                   '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd',
                   '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi',
                   '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gt',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gn',
                   '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gc',
                   '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr',
                   '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gs',
                   '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', ',e',
                   '<cmd>lua vim.diagnostic.open_float(' ..
                     '{ border = "rounded" })<CR>', opts)
    buf_set_keymap('n', '[d',
                   '<cmd>lua vim.diagnostic.goto_prev(' ..
                     '{ float = { border = "rounded" }})<CR>', opts)
    buf_set_keymap('n', ']d',
                   '<cmd>lua vim.diagnostic.goto_next(' ..
                     '{ float = { border = "rounded" }})<CR>', opts)
    buf_set_keymap('n', 'K',
                   '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', ',F',
                   '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    buf_set_keymap('n', ',wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', ',wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', ',wl',
                   '<cmd>lua print(vim.inspect(' ..
                     'vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  end

  local capabilities = require'cmp_nvim_lsp'.default_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = {
    'bashls', 'clangd', 'gopls', 'hls', 'perlpls', 'rust_analyzer'
  }
  for _, lsp in ipairs(servers) do
    local setup = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150
      }
    }
    if lsp == 'hls' then
      setup.settings = {
        haskell = {
          formattingProvider = 'fourmolu',
          plugin = {
            semanticTokens = { globalOn = true }
          }
        }
      }
      setup.filetypes = { 'haskell', 'lhaskell', 'cabal' }
    end
    nvim_lsp[lsp].setup(setup)
  end

  local ufo_ft_map = {
    lsp = { 'c', 'cpp', 'go', 'haskell', 'perl', 'rust' }
  }

  local ufo_virt_text = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰏢 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, {chunkText, hlGroup})
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may be less than 2nd argument,
        -- need padding
        if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'FoldAnno'})
    return newVirtText
  end

  require'ufo'.setup {
    provider_selector = function(bufnr, filetype, buftype)
      if buftype == 'nofile' then
        return ''
      end
      local function contains(tbl, val)
        if tbl then
          for i = 1, #tbl do
            if tbl[i] == val then
              return true
            end
          end
        end
        return false
      end
      local ret = ''
      if contains(ufo_ft_map.disabled, filetype) then
        return ''
      elseif contains(ufo_ft_map.lsp, filetype) then
        ret = { 'lsp', 'treesitter' }
      else
        ret = { 'treesitter', 'indent' }
      end
      vim.keymap.set('n', 'zR', require'ufo'.openAllFolds,
                     { buffer = true })
      vim.keymap.set('n', 'zM', require'ufo'.closeAllFolds,
                     { buffer = true })
      vim.keymap.set('n', 'zr', require'ufo'.openFoldsExceptKinds,
                     { buffer = true })
      vim.keymap.set('n', 'zm', require'ufo'.closeFoldsWith,
                     { buffer = true })
      return ret
    end,
    fold_virt_text_handler = ufo_virt_text,
    close_fold_kinds_for_ft = {
      default = { 'comment', 'imports' },
      pandoc = { 'fenced_code_block' },
      rst = { 'directive' }
    },
    preview = {
      win_config = {
        border = 'none',
        winhighlight = 'NormalFloat:Folded,FloatBorder:Folded',
        winblend = 0
      }
    }
  }

  vim.keymap.set('n', 'zK', function()
    require'ufo'.peekFoldedLinesUnderCursor()
  end)

  -- outline.nvim
  require'outline'.setup {
    providers = {
      priority = { 'lsp', 'treesitter' },
    },
    outline_items = {
      highlight_hovered_item = true,
      auto_set_cursor = true,
      show_symbol_details = true,
      show_symbol_lineno = false,
      auto_update_events = {
        follow = { 'CursorHold' },
        -- BufEnter is missing in the following list because it's called
        -- from s:open_outline() which gets triggered on BufEnter *
        items = {
          'InsertLeave', 'WinEnter', 'BufWinEnter', 'TabEnter',
          'BufWritePost'
        }
      }
    },
    guides = {
      enabled = true
    },
    preview_window = {
      auto_preview = false,
      border = 'rounded',
      winhl = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
      winblend = 0
    },
    outline_window = {
      position = 'right',
      width = 42 + vim.o.columns % 2,
      relative_width = false,
      auto_close = false,
      show_numbers = false,
      show_cursor_line = true,
      hide_cursor = true,
      show_relative_numbers = false,
      -- use plugin beacon instead
      jump_highlight_duration = false,
      wrap = false
    },
    symbol_folding = {
      markers = { '', '' },
      autofold_depth = 1,
      auto_unfold = {
        hovered = true
      }
    },
    symbols = {
      icon_source = 'lspkind'
    },
    keymaps = {
      close = {},
      goto_location = "<Cr>",
      peek_location = "o",
      hover_symbol = "K",
      toggle_preview = "q",
      rename_symbol = "r",
      code_actions = "a",
      fold = "-",
      unfold = "+",
      fold_all = "=",
      unfold_all = "O",
      fold_reset = "R"
    }
  }

  -- LSP diagnostics setup
  vim.diagnostic.config {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false
  }

  -- Send diagnostics to quickfix list
  do
    local method = "textDocument/publishDiagnostics"
    local default_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] =
      function(err, method, result, client_id, bufnr, config)
        default_handler(err, method, result, client_id, bufnr, config)
        vim.diagnostic.setqflist({ open = false })
      end
  end

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  vim.ui.select = require'popui.ui-overrider'

  vim.lsp.handlers['textDocument/codeAction'] =
    require'lsputil.codeAction'.code_action_handler
  vim.lsp.handlers['textDocument/references'] =
    require'lsputil.locations'.references_handler
  vim.lsp.handlers['textDocument/definition'] =
    require'lsputil.locations'.definition_handler
  vim.lsp.handlers['textDocument/declaration'] =
    require'lsputil.locations'.declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] =
    require'lsputil.locations'.typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] =
    require'lsputil.locations'.implementation_handler
  vim.lsp.handlers['textDocument/documentSymbol'] =
    require'lsputil.symbols'.document_handler
  vim.lsp.handlers['workspace/symbol'] =
    require'lsputil.symbols'.workspace_handler
EOF

let g:popui_border_style = "rounded"
" }}}


" ---- Completion with nvim-cmp and ultisnips settings {{{1
" ----
lua <<EOF
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup {
    completion = {
      completeopt = 'menu,menuone,noselect'
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-up>'] = cmp.mapping.scroll_docs(-4),
      ['<C-down>'] = cmp.mapping.scroll_docs(4),
      ['<C-space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-right>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      { name = 'buffer', option = { keyword_pattern = [[\k\+]] } }
    }),
    formatting = {
      format = lspkind.cmp_format()
    },
    window = {
      documentation = cmp.config.window.bordered({
        border = 'rounded',
        winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder'
      })
    },
    experimental = {
      ghost_text = false
    }
  }
EOF

let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" }}}


" ---- Easy navigation between tabs and buffers {{{1
" ----
set switchbuf=usetab
" use bufhidden=delete or bufhidden=wipe to enable the following <C-arrow>
" mappings; if 'delete' is used then cursor won't move to reopen buffers, but
" when wipe is used <C-t> won't work
autocmd BufEnter * if empty(&buftype) | setlocal bufhidden=delete | endif
" this will fix bug with bufhidden=delete mentioned above
autocmd BufEnter * if empty(&buftype) | setlocal buflisted | endif

" jump to the last known cursor position on opening a buffer
let g:JumpToLastChangeOnBufOpen = 1

autocmd BufReadPre * let b:start_jump_done = !g:JumpToLastChangeOnBufOpen
autocmd BufReadPost *
            \ if empty(&buftype) && exists('b:start_jump_done') &&
            \     !b:start_jump_done |
            \     silent! exe 'normal! g`"' | let b:start_jump_done = 1 |
            \ endif

fun! s:wintoggle_cmd(cmd, bufname)
    let l:bufname = a:bufname == '__Tagbar__*' &&
                \ exists('t:tagbar_buf_name') ? t:tagbar_buf_name : a:bufname
    let status = bufwinnr(l:bufname)
    let lastwin = winnr('$')
    let i = 1
    while i <= lastwin
        if !getwinvar(i, '&winfixheight')
            call setwinvar(i, '&winfixheight', 1)
            call setwinvar(i, 'saveheight', 1)
        else
            call setwinvar(i, 'saveheight', 0)
        endif
        let i += 1
    endwhile
    exe a:cmd
    if (l:bufname == '__Tagbar__*')
        let l:bufname = exists('t:tagbar_buf_name') ? t:tagbar_buf_name : ''
    endif
    if (!empty(l:bufname) && bufwinnr(l:bufname) != status)
        let t:wintoggle_tagbar_done = 1
        wincmd =
        if !exists('t:winhidden')
            let t:winhidden = {}
        endif
        if bufwinnr(l:bufname) == -1
            let t:winhidden[l:bufname] = 1
        elseif exists('t:winhidden[l:bufname]')
            unlet t:winhidden[l:bufname]
        endif
    endif
    let lastwin = winnr('$')
    let i = 1
    while i <= lastwin
        if getwinvar(i, 'saveheight')
            call setwinvar(i, '&winfixheight', 0)
        endif
        let i += 1
    endwhile
endfun

nmap <silent> <C-left>   :wincmd h<CR>
nmap <silent> <C-right>  :wincmd l<CR>
nmap <silent> <C-up>     :wincmd k<CR>
nmap <silent> <C-down>   :wincmd j<CR>
nmap <silent> ,<left>    :tabp<CR>
nmap <silent> ,<right>   :tabn<CR>
nmap <silent> <C-p><C-p> :Telescope find_files<CR>
nmap <silent> <C-p>f     :Telescope file_browser<CR>
nmap <silent> <C-p>g     :Telescope live_grep<CR>
nmap <silent> <C-p>s     :Telescope treesitter<CR>
nmap <silent> <C-p>m     :Telescope marks<CR>

" close tab / quit vim if there are only ancillary buffers in the current tab
" after quitting the current buffer
autocmd QuitPre * call init#quit_pre_hook()
autocmd BufUnload * call init#close_last_ancillary_buffers()

" toggle commands for tagbar, mundo, nerdtree and other are also here
nmap <silent> <C-p>t     :call
            \ <SID>wintoggle_cmd('TagbarToggle', '__Tagbar__*')<CR>
nmap <silent> <C-p>u     :call
            \ <SID>wintoggle_cmd('MundoToggle', '__Mundo__')<CR>
nmap <silent> <C-p>e     :call
            \ <SID>wintoggle_cmd('NERDTreeToggle', 'NERD_tree_*')<CR>
nmap <silent> <C-p>o     :call
            \ <SID>wintoggle_cmd('Outline!', 'OUTLINE_*')<CR>
" go to bottom-right window (tagbar etc.)
nmap <silent> <C-p>[     :wincmd b<CR>

nmap          <C-p>-     10<C-w>-
nmap          <C-p>=     10<C-w>+

let g:mundo_width = 40
let g:mundo_preview_height = 20
let g:mundo_prefer_python3 = 1

" set winfixwidth in Mundo windows (as it is not set in the plugin)
autocmd BufEnter *
            \ if match(bufname('%'), '__Mundo_\%(Preview\)\=_') != -1 |
            \     setlocal winfixwidth |
            \ endif

" quickly remove all current highlights
nmap          ,l         :nohl<CR>

" quickly toggle paste mode
nmap <silent> ,p         :set paste! <Bar> set paste?<CR>

" quickly toggle spellcheck
nmap <silent> ,s         :set spell! <Bar> set spell?<CR>

" disable Unicode symbols in linux console if font does not support them
let g:DisableUnicodeSymbols = &term =~? '^linux' &&
            \ empty($CONSOLEFONT_HAS_VIM_UNICODE_SYMB)

" set good line breaks
set linebreak
if g:DisableUnicodeSymbols
    set showbreak=\ >>>\ 
else
    set showbreak=\ \ ↳\ \ 
endif

" fold blocks with '+'
nmap +          v%zf

set timeout timeoutlen=1000 ttimeoutlen=50
set updatetime=1000

filetype plugin indent on

set spelllang=ru_ru,en_us

" follow golang formatting style
autocmd FileType go setlocal noexpandtab
            \ tabstop=6 softtabstop=6 shiftwidth=6 textwidth=99
            \ listchars=tab:\ \ ,trail:·,nbsp:⍽
" set sensible textwidth for tex, rst and pandoc files
autocmd FileType tex,rst,pandoc setlocal textwidth=80 colorcolumn=81
" set appropriate conceallevel for tex files
autocmd FileType tex setlocal conceallevel=2
" nocindent for pandoc
autocmd FileType pandoc setlocal nocindent

" disable autocommenting lines following a commented line
autocmd FileType c,cpp
            \ setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://

set wildmenu
set wildmode=list:longest,full

" insert combining acute accent when writing Russian texts easily
imap <C-v>ё  <C-v>u0301

autocmd BufRead *.csv setlocal nomodeline

nmap <silent> ,vv :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
nmap <silent> ,vf :GetFgColorUnderCursor<CR>
nmap <silent> ,vb :GetBgColorUnderCursor<CR>
nmap <silent> ,vt :TSPlaygroundToggle<CR>
nmap <silent> ,vc :TSHighlightCapturesUnderCursor<CR>
nmap <silent> ,vm :CccHighlighterToggle<CR>
nmap <silent> ,vp :CccPick<CR>

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" beacon settings
let g:beacon_enable = 0
let g:beacon_show_jumps = 0
autocmd VimEnter * if !&diff | let g:beacon_enable = 1 | endif
nmap <silent> <space> :Beacon<CR>
" }}}


" ---- Git-related plugins settings {{{1
" ----
let g:git_messenger_no_default_mappings = v:true
nmap ,g <Plug>(git-messenger)

let g:git_messenger_floating_win_opts = { 'border': 'rounded' }
let g:git_messenger_popup_content_margins = v:false

nmap <silent> ,ha   :GV<CR>
nmap <silent> ,hf   :GV!<CR>

lua <<EOF
  require'gitsigns'.setup {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' }
    },
    attach_to_untracked = false,
    current_line_blame = false,
    sign_priority = 6,
    preview_config = {
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      -- Actions
      map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', function() gs.blame_line{full=true} end)
      map('n', '<leader>tb', gs.toggle_current_line_blame)
      map('n', '<leader>hd', gs.diffthis)
      map('n', '<leader>hD', function() gs.diffthis('~') end)
      map('n', '<leader>td', gs.toggle_deleted)
      map('n', '<leader>tw', gs.toggle_word_diff)

      -- Text object
      map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
EOF
" }}}


" ---- Committia settings {{{1
" ----
let g:committia_hooks = {}

fun! g:committia_hooks.edit_open(info)
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    imap <buffer><C-down> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-up> <Plug>(committia-scroll-diff-up-half)
endfun
" }}}


" ---- Lexima settings {{{1
" ----
let g:lexima_no_default_rules = 1

" load lexima rules on the first switch to insert mode after autocmd
" InsertEnter of plugin vim-xkbswitch was done: this is to avoid translating
" insert mappings with Э, э, etc., which will break normal entering of such
" characters; to fulfill this, the rules are declared and enabled with
" autocmd InsertEnter in after/plugin/lexima.vim
" }}}


" ---- Emulate file-line plugin for any new file and file autocompletion {{{1
" ----
let g:loaded_file_line = 1

fun! s:file_line(file)
    let l:parts = matchlist(a:file, '\(.\{-1,}\):\(\d\+\)\%(:\(\d\+\)\)\?$')
    if empty(l:parts) || !filereadable(l:parts[1])
        if !empty(glob(escape(a:file, '[]*?').'*')) && empty(&buftype)
            call feedkeys(':e '.a:file."\<Tab>", 't')
        endif
        return
    endif
    let l:bufn = bufnr("%")
    exe 'keepalt edit' fnameescape(l:parts[1])
    exe 'bwipeout' l:bufn
    filetype detect
    exe l:parts[2]
    if foldlevel(l:parts[2]) > 0
        normal! zv
    endif
    if !empty(l:parts[3])
        exe 'normal!' l:parts[3].'|'
    endif
    normal! zz
    let b:start_jump_done = 1
endfun

autocmd BufNewFile * call s:file_line(expand('<afile>'))
" }}}


" ---- Airline settings {{{1
" ----
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox_material'
let g:airline_detect_iminsert = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#enabled = 0

let g:airline_theme_patch_func = 'init#airline_theme_patch'

let s:SudoAdminIcon = g:DisableUnicodeSymbols ? '' : ' '

" load custom g:airline_section_a once at the first BufWinEnter event
" (note that it happens before VimEnter!)
autocmd BufWinEnter,VimEnter * call init#setup_airline(s:SudoAdminIcon)
" }}}


" ---- Pandoc settings {{{1
" ----
let g:pandoc#modules#disabled = ['menu', 'spell', 'folding']
let g:pandoc#formatting#mode = 'ha'
let g:pandoc#formatting#textwidth = 79
" syntax and folding is up to treesitter!
" let g:pandoc#folding#mode = 'stacked'
" let g:pandoc#folding#level = 1
" let g:pandoc#folding#fold_fenced_codeblocks = 1
" let g:pandoc#folding#fdc = 0
let g:pandoc#after#modules#enabled = ['tablemode']
let g:pandoc#biblio#sources = 'b'

" regard any README.md as a gfm file and setup the right equalprg
autocmd FileType pandoc
            \ let b:PandocMarkdownFlavor =
            \     expand('%:t') ==? "README.md" ? "gfm" : "markdown" |
            \ let g:pandoc#formatting#equalprg = "pandoc -t ".
            \     b:PandocMarkdownFlavor." --columns ".
            \     g:pandoc#formatting#textwidth |
            \ let &l:equalprg = g:pandoc#formatting#equalprg.' '.
            \     g:pandoc#formatting#extra_equalprg
" }}}


" ---- Source code tags and grep settings {{{1
" ----
set tagstack

" mapping for moving forward in the tagstack
nmap ,T  :tag<CR>

" mappings for opening/closing various preview windows
nmap <silent> ,,  :call init#open_tag('<C-r>=expand("<cword>")<CR>')<CR>
nmap ,qo          :botright copen<CR>
nmap ,qq          :cclose<CR>
nmap <silent> ,qw :call init#close_tag_win()<CR>

nmap <silent> ,U :call init#win_occupy_vert_space('tagbar')<CR>

" gutentags settings
let g:gutentags_exclude_filetypes = ['svn', 'cvs', 'gitcommit', 'hgcommit']
" }}}


" ---- Switching to alternative source code files {{{1
" ----
nmap ,aa  :FSHere<CR>
nmap ,as  :FSSplitAbove<CR>
nmap ,ax  :FSSplitAbove<CR>
nmap ,av  :FSSplitRight<CR>
nmap ,aj  :FSSplitRight<CR>

" fswitch settings for opening buffers
augroup fswitch
    au!
    autocmd BufEnter *.{cpp,cc,cxx,c++} let b:fswitchdst = 'hpp,hh,h' |
            \ let b:fswitchlocs = '../include,./' | let b:fsnonewfiles = 'on'
    autocmd BufEnter *.c let b:fswitchdst = 'h' |
            \ let b:fswitchlocs = '../include,./' | let b:fsnonewfiles = 'on'
    autocmd BufEnter *.{hpp,hh,icc} let b:fswitchdst = 'cpp,cc,cxx,c++' |
            \ let b:fswitchlocs = '../src,./' | let b:fsnonewfiles = 'on'
    autocmd BufEnter *.h let b:fswitchdst = 'cpp,cc,cxx,c++,c' |
            \ let b:fswitchlocs = '../src,./' | let b:fsnonewfiles = 'on'
augroup END
" }}}


" ---- Commands and mappings for formatting hints highlights {{{1
" ----
let g:RightBorder = 80
highlight FormatHints term=standout
            \ cterm=NONE ctermfg=244 ctermbg=229
            \ gui=NONE guifg=#808080 guibg=#ffffaf
" restore FormatHints after switching to a color scheme that may clear it off
autocmd ColorScheme * highlight FormatHints term=standout
            \ cterm=NONE ctermfg=244 ctermbg=229
            \ gui=NONE guifg=#808080 guibg=#ffffaf

command -bar ShowFormatHints call init#formathints()
command -bar HideFormatHints call init#formathints_hide()
command      HideDosEols     call init#doseol_hide()

nmap <silent> ,f :if !exists("w:m1") <Bar><Bar> w:m1 == 0 <Bar>
            \ ShowFormatHints <Bar> echo "Show format hints" <Bar> else <Bar>
            \ HideFormatHints <Bar> echo "Hide format hints" <Bar> endif<CR>
nmap          ,r :HideDosEols<CR>
nmap <silent> ,m :if &colorcolumn == b:RightBorder + 1 <Bar>
            \ setlocal colorcolumn= <Bar> elseif !&colorcolumn <Bar>
            \ let &l:colorcolumn = b:RightBorder + 1 <Bar> endif<CR>

" adjust colorcolumn and g:RightAlign_RightBorder when entering a buffer with
" different value of 'textwidth'
autocmd BufEnter *
        \ let b:RightBorder = &textwidth > 0 ? &textwidth : g:RightBorder |
        \ let g:RightAlign_RightBorder = b:RightBorder |
        \ if &colorcolumn | let &l:colorcolumn = b:RightBorder + 1 | endif

" show colorcolumn when committing to svn, cvs or other VCS
autocmd FileType svn,cvs,gitcommit,hgcommit
            \ setlocal textwidth=80 colorcolumn=81
" }}}


" ---- Tagbar settings {{{1
" ----
if executable('ctags-universal')
    " prefer Universal ctags in Ubuntu
    " (in Fedora, ctags executable is always Universal ctags)
    let g:tagbar_ctags_bin = 'ctags-universal'
endif
let g:tagbar_width = 42 + &columns % 2
let g:tagbar_sort = 0

if g:DisableUnicodeSymbols
    let g:tagbar_iconchars = ['+', '-']
endif

" switch to a normal buffer when leaving a tab
autocmd TabLeave * if &filetype == 'tagbar' | wincmd p | endif

autocmd BufNewFile,BufReadPre *.snippets let b:tagbar_ignore = 1

let g:tagbar_win_ft_skip = ['tagbar', 'alpha']

fun! s:open_tagbar(buf_enter)
    if a:buf_enter && exists('b:open_tagbar_done')
        return
    endif
    let b:open_tagbar_done = 1
    if &diff || index(g:tagbar_win_ft_skip, &filetype) != -1 ||
                \ exists('t:winhidden[t:tagbar_buf_name]')
        return
    endif
    if empty(&buftype)
        setlocal buflisted
    endif
    call s:wintoggle_cmd('call tagbar#autoopen(0)', '__Tagbar__*')
endfun

fun! s:open_outline(timer_id)
    if a:timer_id != -1 && exists('t:open_outline_done')
        " refresh outline if a quicker provider has already grabbed it
        OutlineRefresh
        return
    endif
    if &diff || exists('t:open_outline_done') ||
                \ !v:lua.require'outline.providers'.has_provider()
        return
    endif
    let t:open_outline_done = 1
    if empty(&buftype)
        setlocal buflisted
    endif
    call s:wintoggle_cmd('OutlineOpen!', 'OUTLINE_*')
endfun

let g:OutlineImpl = 'outline'

if g:OutlineImpl == 'tagbar'
    " automatically open tagbar on vim's start or a new tab is open if
    " filetype of the open file is supported by ctags and tagbar (when not
    " in diff mode);
    autocmd BufEnter * call s:open_tagbar(1)
    " BufWritePost shall trigger tagbar opening on the first write to
    " a new file
    autocmd BufWritePost * call s:open_tagbar(0)
elseif g:OutlineImpl == 'outline'
    autocmd BufEnter * call timer_start(500, 's:open_outline', {'repeat': 9})
    autocmd BufWritePost * call s:open_outline(-1)
endif

" setting specific ambiwidth prevents from printing garbage in the first two
" columns on the second row of the screen when tagbar automatically opens on
" vim loading (the issue was introduced in vim v8.0.0567)
set ambiwidth=single

let g:tagbar_type_haskell = {
    \ 'ctagsbin'    : 'hasktags',
    \ 'ctagsargs'   : '-x -c -o-',
    \ 'kinds'       : [
    \     'm:modules:0:1',
    \     'd:data:0:1',
    \     'd_gadt:data gadt:0:1',
    \     'nt:newtype:0:1',
    \     'c:classes:0:1',
    \     'i:instances:0:1',
    \     'cons:constructors:0:1',
    \     'c_gadt:constructor gadt:0:1',
    \     'c_a:constructor accessors:1:1',
    \     't:type names:0:1',
    \     'pt:pattern types:0:1',
    \     'pi:pattern implementations:0:1',
    \     'ft:function types:0:1',
    \     'fi:function implementations:0:1',
    \     'o:others:0:1'
    \ ],
    \ 'sro'          : '.',
    \ 'kind2scope'   : {
    \     'm'        : 'module',
    \     'd'        : 'data',
    \     'd_gadt'   : 'd_gadt',
    \     'c_gadt'   : 'c_gadt',
    \     'nt'       : 'newtype',
    \     'cons'     : 'cons',
    \     'c_a'      : 'accessor',
    \     'c'        : 'class',
    \     'i'        : 'instance'
    \ },
    \ 'scope2kind'   : {
    \     'module'   : 'm',
    \     'data'     : 'd',
    \     'newtype'  : 'nt',
    \     'cons'     : 'c_a',
    \     'd_gadt'   : 'c_gadt',
    \     'class'    : 'ft',
    \     'instance' : 'ft'
    \ }
\ }
" }}}


" ---- Haskell settings {{{1
" ----
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_before_where = 4
let g:haskell_indent_after_bare_where = 4
let g:haskell_indent_guard = 4
let g:haskell_indent_in = 0
" }}}


" ---- Better mappings for plugin Mark {{{1
" ----
nmap <C-k><C-k> <Plug>MarkSet
nmap <C-k>r     <Plug>MarkRegex
vmap <C-k><C-k> <Plug>MarkSet
vmap <C-k>r     <Plug>MarkRegex
nmap <C-k>n     <Plug>MarkSearchCurrentNext
nmap <C-k>p     <Plug>MarkSearchCurrentPrev
nmap <C-k>]     <Plug>MarkSearchAnyNext
nmap <C-k>[     <Plug>MarkSearchAnyPrev
nmap <C-k>c     <Plug>MarkAllClear
nmap <C-k>t     <Plug>MarkToggle
nmap <C-k>s     :MarkSave<CR>
nmap <C-k>l     :MarkLoad<CR>

" adjust highlight priorities between plugins Mark and Illuminate
let g:mwMaxMatchPriority = -10
let g:Illuminate_highlightPriority = -20
" }}}


" ---- Treesitter-context and nvim_context_vt plugins settings {{{1
" ----
lua <<EOF
  require'treesitter-context'.setup {
    enable = true,
    throttle = false,
    pin = false,
    max_lines = 0,
    patterns = {
      haskell = {
        'bind', 'conditional', 'data_type', 'do', 'match', 'multi_way_if'
      },
      json = {
        'pair'
      },
      rust = {
        'enum', 'impl_item', 'struct'
      },
      yaml = {
        'block_mapping_pair'
      }
    }
  }
EOF

if g:DisableUnicodeSymbols
    let g:ContextTrailingMarker = '<-- '
    let g:ContextNewlineMarker = ' .. '
else
    let g:ContextTrailingMarker = '  '
    let g:ContextNewlineMarker = ' ␤ '
endif

lua <<EOF
  local ts = require'vim.treesitter'
  local ts_utils = require'nvim-treesitter.ts_utils'
  local context_vt_utils = require'nvim_context_vt.utils'
  local min_node_size = 21

  local function is_ft_function(node, ft)
    return ft == 'haskell' and node:type() == 'function'
        or ft == 'rust' and node:type() == 'function_item'
  end

  local function find_node(node, type)
    local children = ts_utils.get_named_children(node)
    for _, child in ipairs(children) do
      if child:type() == type then
        return child
      end
    end
    for _, child in ipairs(children) do
      local deep_child = find_node(child, type)
      if deep_child ~= nil then
        return deep_child
      end
    end
    return nil
  end

  require'nvim_context_vt'.setup {
    disable_ft = { 'bash', 'haskell', 'markdown', 'pandoc', 'perl' },
    custom_parser = function(node, ft)
      local is_function_definition = node:type() == 'function_definition'
      local is_function = is_function_definition or is_ft_function(node, ft)
      local start_line, _, end_line, _ = ts.get_node_range(node)
      if not is_function and end_line - start_line < min_node_size then
        return nil
      end
      local node_text = vim.split(ts.get_node_text(node, 0), '\n')
      local text = node_text[1]
      if is_function_definition then
        local decl = find_node(node, 'function_declarator')
        if decl ~= nil then
          local start_line_decl, _, _, _ = ts.get_node_range(decl)
          if start_line_decl ~= nil then
            local offset = start_line_decl - start_line
            for i = 1, offset do
              text = text .. vim.g.ContextNewlineMarker
              local next_node = node_text[i + 1]
              if next_node ~= nil then
                text = text .. string.gsub(next_node, '^%s+', '')
              end
            end
          end
        end
      else
        if not string.match(text, '%S+%s+') and #node_text > 1 then
          text = text .. vim.g.ContextNewlineMarker
          local next_node = node_text[2]
          if next_node ~= nil then
            text = text .. string.gsub(next_node, '^%s+', '')
          end
        end
      end
      return vim.g.ContextTrailingMarker .. text
    end,
    custom_validator = function(node, ft, opts)
      if node:type() == 'for_loop' then
        return true
      end
      return context_vt_utils.default_validator(node, ft, opts)
    end
  }
EOF
" }}}


" ---- Tablemode settings {{{1
" ----
let g:table_mode_verbose = 1
" }}}


" ---- LanguageTool settings {{{1
" ----
let g:languagetool_jar =
            \ '/usr/share/LanguageTool/languagetool-commandline.jar'
" }}}


" ---- Automatic keyboard layout switching upon entering/leaving {{{1
" ---- insert mode using xkb-switch utility and plugin xkbswitch
" ----
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchNLayout = 'us'
let g:XkbSwitchILayout = 'us'
let g:XkbSwitchSkipIMappings =
            \ {'c'   : ['.', '>', ':', '{<CR>', '/*', '/*<CR>'],
            \  'cpp' : ['.', '>', ':', '{<CR>', '/*', '/*<CR>']}
let g:XkbSwitchAssistNKeymap = 1    " for commands f and r
let g:XkbSwitchDynamicKeymap = 1
let g:XkbSwitchKeymapNames =
            \ {'ru' : 'russian-jcukenwin', 'de' : 'german-qwertz'}
" quickly toggle keyboard layout for f and r commands in normal mode
" (<C-^> also switches keyboard layout in search mode)
let g:XkbSwitchIminsertToggleKey = '<C-^>'
let g:XkbSwitchIminsertToggleEcho = 0

let g:XkbSwitchIEnterHook = 'init#xkb_switch_ienter_hook'

" automatic keyboard layout switching in a simple dictionary in insert mode
" (may use vimwiki or tablemode engine)
let g:mdictImpl = 'tablemode'
let g:mdictBaseColors = {'original':   [189, '#d7d7ff'],
                       \ 'translated': [194, '#d7ffd7'],
                       \ 'extra':      [191, '#d7ff5f']}

augroup mdict
    au!
    autocmd BufNewFile,BufRead *.mdict setlocal textwidth=0 | EnableXkbSwitch
    if g:mdictImpl == 'vimwiki'
        " filetype is a subclass of vimwiki and must have extension '.mdict';
        " there must exist syntax support in dedicated script
        " $HOME/.vim/after/syntax/vimwiki.vim to define matches for original
        " and translated colums 'mdictOriginal' and 'mdictTranslated'
        autocmd BufNewFile,BufRead *.mdict setlocal ft=vimwiki
        autocmd BufNewFile         *.mdict VimwikiTable 2 2
        autocmd BufNewFile         *.mdict delete | startinsert
    elseif g:mdictImpl == 'tablemode'
        autocmd BufNewFile,BufRead *.mdict setlocal ft=_mdict_
        autocmd BufNewFile,BufRead *.mdict let g:table_mode_auto_align = 0
        autocmd BufNewFile,BufRead *.mdict TableModeEnable
        autocmd BufNewFile,BufRead *.mdict call init#mdict_syntax_load()
        " convenient imaps <C-Up> and <C-Down> to insert bars into the table
        autocmd BufNewFile,BufRead *.mdict imap <C-up> <Bar><Space>
        autocmd BufNewFile,BufRead *.mdict imap <C-down> <Bar>
    endif
augroup END

let g:XkbSwitchSyntaxRules = [
            \ {'pat': '*.mdict', 'in': ['mdictOriginal', 'mdictTranslated']} ]
" }}}


" ---- Settings for plugins right_align and prev_indent {{{1
" ----
let g:RightAlign_RightBorder = g:RightBorder
let g:RightAlign_ShiftRound = 1

imap <silent> <C-b>       <Plug>RightAlign
nmap <silent> <C-k>b      :RightAlign<CR>
vmap <silent> <C-k>b      :RightAlign<CR>

imap <silent> <C-g><C-g>  <Plug>PrevIndent
nmap <silent> <C-k>k      :PrevIndent<CR>
imap <silent> <C-g>g      <Plug>AlignWith
nmap <silent> <C-k>g      :AlignWith<CR>
" }}}


" ---- Settings for plugin publish_helper {{{1
" ----
let g:PhHighlightEngine = 'treesitter'
let g:PhLinenrAsTblColumn = 1
let g:PhHtmlPreAttrs =
            \ 'style="white-space: pre-wrap; background: #2E3436; '.
            \ 'padding: 12px; font-size: 16px"'
let g:PhLinenrColumnAttrs =
            \ 'style="font-size: 16px; color: #82766C; background: #2E3436"'
let g:PhLinenrColumnBorderAttrs = '1px solid'
let g:PhLinenrColumnWidth = '2.5em'
let g:PhLinenrFgColor = '#204A87'
let g:PhLinenrTblBgColor = '#2E3436'
let g:PhLinenrTblBorderSpacing = '12px'
" }}}

