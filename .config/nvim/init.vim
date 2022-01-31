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
Plug 'glepnir/oceanic-material'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'franbach/miramare'
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'ludovicchabant/vim-gutentags'
Plug 'cohama/lexima.vim'
Plug 'machakann/vim-sandwich'
Plug 'kshenoy/vim-signature'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'simrat39/symbols-outline.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'onsails/lspkind-nvim'
Plug 'wellle/context.vim'
Plug 'romgrk/nvim-treesitter-context'
Plug 'haringsrob/nvim_context_vt'
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'psliwka/vim-smoothie'
Plug 'bogado/file-line'
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
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

"let g:oceanic_material_transparent_background = 1
"let g:oceanic_material_allow_bold = 1
"let g:oceanic_material_allow_italic = 1
"colorscheme oceanic_material
"let g:material_disable_background = 1
"let g:material_style = 'darker'
"colorscheme material
"let g:miramare_transparent_background = 1
"let g:miramare_enable_italic = 1
"let g:miramare_enable_bold = 1
"colorscheme miramare
"let g:edge_style = 'neon'
"let g:edge_transparent_background = 1
"let g:edge_enable_italic = 1
"colorscheme edge

" seamless FloatBorder around NormalFloat for gruvbox-material colorscheme
autocmd ColorScheme *
            \ highlight FloatBorder
                \ cterm=NONE ctermbg=237 ctermfg=186
                \ gui=NONE guibg=#45403d guifg=#d7d787

let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1

colorscheme gruvbox-material

let g:CustomTSVariableHighlight = v:true

if g:CustomTSVariableHighlight
    highlight TSVariable term=NONE
                \ ctermfg=49 ctermbg=NONE guifg=#00ee9e guibg=NONE
endif
" }}}


" ---- Miscellaneous basic customizations {{{1
" ----
set nocompatible

set ruler

set showcmd
set title

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
set foldlevel=1

set mouse=a
set hlsearch
set noincsearch

" make vertical split open on the right
set splitright

let mapleader = ','
let g:netrw_winsize = 25
" }}}


" ---- Setup treesitter {{{1
" ----
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'haskell', 'json',
                         'python', 'r', 'rust', 'toml', 'vim', 'yaml' },
    highlight = {
      enable = true,
      disable = { 'haskell' },
      additional_vim_regex_highlighting = true,
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
  require'lspconfig'.clangd.setup{}
  require'lspconfig'.hls.setup{}
  require'lspkind'.init()

  local nvim_lsp = require('lspconfig')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', ',e', '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" }})<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  end

  local capabilities = require'cmp_nvim_lsp'.
    update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { "clangd", "hls" }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  -- symbols-outline.nvim
  vim.g.symbols_outline = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = true,
      position = 'right',
      width = 25,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = true,
      keymaps = {
          close = "<Esc>",
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "K",
          toggle_preview = "q",
          rename_symbol = "r",
          code_actions = "a"
      },
      lsp_blacklist = {},
      symbol_blacklist = {}
  }

  -- LSP Enable diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = false,
          underline = true,
          signs = true,
          update_in_insert = false
      })

  -- Send diagnostics to quickfix list
  do
      local method = "textDocument/publishDiagnostics"
      local default_handler = vim.lsp.handlers[method]
      vim.lsp.handlers[method] = function(err, method, result, client_id,
                                          bufnr, config)
          default_handler(err, method, result, client_id, bufnr, config)
          vim.diagnostic.setqflist({ open = false })
      end
  end

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = "rounded"
    }
  )
  
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = "rounded"
    }
  )

  vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
  vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
  vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF
" }}}


" ---- Completion with nvim-cmp, lexima and ultisnips settings {{{1
" ----
lua <<EOF
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup({
    completion = {
      completeopt = 'menu,menuone,noselect',
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-up>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-down>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-right>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
    },
    {
      { name = 'buffer', option = { keyword_pattern = [[\k\+]] } }
    }),
    formatting = {
      format = lspkind.cmp_format()
    },
    documentation = {
      border = 'rounded',
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder'
    },
    experimental = {
      ghost_text = false,
      native_menu = false
    }
  })
EOF

" lexima breaks some Cyrillic inputs (such as Э, э, etc.)
autocmd FileType tex,rst,pandoc let b:lexima_disabled = 1
            \ | call lexima#clear_rules()

let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" }}}


" ---- Easy navigation between tabs and buffers {{{1
" ----
set switchbuf=usetab
" use bufhidden=delete or bufhidden=wipe to enable following <C-arrow>
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
                \ !b:start_jump_done |
            \ silent! exe 'normal! g`"' | let b:start_jump_done = 1 |
            \ endif

fun! <SID>wintoggle_cmd(cmd, bufname)
    let status = bufwinnr(a:bufname)
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
    if (bufwinnr(a:bufname) != status)
        wincmd =
        if !exists('t:winhidden')
            let t:winhidden = {}
        endif
        exe "if bufwinnr('".a:bufname."') == -1 | let t:winhidden['".
                    \ a:bufname."'] = 1 | elseif exists('t:winhidden[\"".
                    \ a:bufname."\"]') | unlet t:winhidden['".a:bufname.
                    \ "'] | endif"
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
nmap <silent> <C-p>b     :Telescope file_browser<CR>
nmap <silent> <C-p>g     :Telescope live_grep<CR>
nmap <silent> <C-p>s     :Telescope treesitter<CR>
nmap <silent> <C-p>h     :Telescope help_tags<CR>

" toggle commands for tagbar, mundo, nerdtree and other are also here
nmap <silent> <C-p>t     :call
            \ <SID>wintoggle_cmd('TagbarToggle', '__Tagbar__')<CR>
nmap <silent> <C-p>u     :call
            \ <SID>wintoggle_cmd('MundoToggle', '__Mundo__')<CR>
nmap <silent> <C-p>e     :call
            \ <SID>wintoggle_cmd('NERDTreeToggle', 'NERD_tree_*')<CR>
nmap <silent> <C-p>o     :call
            \ <SID>wintoggle_cmd('SymbolsOutline', '__Tagbar__')<CR>
" go to bottom-right window (tagbar etc.)
nmap <silent> <C-p>[     :wincmd b<CR>

nmap          <C-p>-     10<C-w>-
nmap          <C-p>=     10<C-w>+

let g:mundo_width = 40
let g:mundo_preview_height = 20
let g:mundo_prefer_python3 = 1

" set winfixwidth in Mundo windows (as it is not set in the plugin)
autocmd BufEnter * if match(bufname('%'), '__Mundo_\%(Preview\)\=_') != -1 |
            \ setlocal winfixwidth | endif

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
" }}}


" ---- Git-messenger settings {{{1
" ----
let g:git_messenger_no_default_mappings = v:true
nmap ,g <Plug>(git-messenger)

let g:git_messenger_floating_win_opts = { 'border': 'rounded' }
let g:git_messenger_popup_content_margins = v:false
" }}}


" ---- Emulate file-line plugin for any new file and file autocompletion {{{1
" ----
let g:loaded_file_line = 1

fun! <SID>file_line(file)
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

autocmd BufNewFile * call <SID>file_line(expand('<afile>'))
" }}}


" ---- Airline settings {{{1
" ----
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox_material'
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#tagbar#flags = 'f'

let g:airline_theme_patch_func = 'AirlineThemePatch'

fun! AirlineThemePatch(palette)
    if !has_key(a:palette.accents, 'red_bold')
        let a:palette.accents.red_bold = ['#d70000', '', 160, '', 'bold']
    endif
endfun

if g:DisableUnicodeSymbols
    let s:SudoAdminFase = ''
else
    let s:SudoAdminFase = 0 ? '🦁' : (1 ? ' ' : '🧔')
endif

" sudo indicator, this must work with both sudo -e and
" alias svim='sudo HOME=$HOME nvim'
call airline#parts#define('sudo', {
            \ 'text': s:SudoAdminFase.'SUDO',
            \ 'condition': '!empty($SUDO_USER) || $_ =~# "/sudo$"',
            \ 'accent': 'red_bold',
            \ })

let g:airline_section_a =
            \ airline#section#create_left(['mode', 'sudo', 'crypt', 'paste',
            \ 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert'])
" }}}


" ---- Pandoc settings {{{1
" ----
let g:pandoc#modules#disabled = ['menu', 'spell']
let g:pandoc#syntax#codeblocks#embeds#langs = ['vim', 'tex', 'sh', 'cpp']
let g:pandoc#formatting#textwidth = 80
let g:pandoc#folding#fold_fenced_codeblocks = 1
let g:pandoc#folding#fdc = 0
let g:pandoc#after#modules#enabled = ["tablemode"]
let g:pandoc#biblio#sources = "b"
" avoid possible folding mess on very long code blocks
autocmd FileType pandoc syntax sync minlines=500
" }}}


" ---- Source code tags and grep settings {{{1
" ----
set tagstack

" mapping for moving forward in the tagstack
nmap ,T  :tag<CR>

" functions for jumping to a tag under cursor in a special split window
let g:TagPWinHeight = 16

fun! <SID>open_tag(tag)
    if empty(a:tag)
        return
    endif
    " BEWARE: command :(s)tag may produce a bigger list than the following
    " call to function taglist()
    if empty(taglist('^'.a:tag.'$'))
        echohl WarningMsg
        echo "No tag '".a:tag."' found"
        echohl None
        return
    endif
    let split = 's'
    let lastwin = winnr('$')
    let curwin = winnr()
    let i = 1
    let save_cursor = []
    while i <= lastwin
        let pwin = getwinvar(i, 'tagpwin')
        if pwin
            " move to the dedicated window: we can return then back if needed
            " (e.g. when user presses just Enter on a list of tags)
            if i != curwin
                exe i."wincmd w"
                let save_cursor = getpos('.')
            endif
            let split = ''
            break
        endif
        let i += 1
    endwhile
    " FIXME: in case of exception when executing command :(s)tag the cursor
    " may stay in the original window
    exe split."tag ".a:tag
    if empty(split) && i != curwin
        " if we stay on same position then return to original window; a better
        " solution would be checking changes in tagstack but it seems to be
        " inaccessible from vim scripts
        if save_cursor == getpos('.')
            exe curwin."wincmd w"
        endif
    endif
    if split == 's' && lastwin < winnr('$')
        exe g:TagPWinHeight."wincmd _"
        set winfixheight
        let w:tagpwin = 1
    endif
endfun

fun! <SID>close_tag_win()
    let lastwin = winnr('$')
    let curwin = winnr()
    let i = 1
    while i <= lastwin
        let pwin = getwinvar(i, 'tagpwin')
        if pwin
            if i != curwin
                exe i."wincmd w"
                wincmd q
                let dstwin = curwin > i ? curwin - 1 : curwin
                exe dstwin."wincmd w"
            else
                wincmd q
            endif
            break
        endif
        let i += 1
    endwhile
endfun

" mappings for opening/closing various preview windows
nmap <silent> ,,  :call <SID>open_tag('<C-r>=expand("<cword>")<CR>')<CR>
nmap ,qo          :botright copen<CR>
nmap ,qq          :cclose<CR>
nmap <silent> ,qw :call <SID>close_tag_win()<CR>

" mapping for making rightmost window left to tagbar occupy all vertical space
"
" --------------    --------------       --------------
" |         |tb|    |    | W  |tb|       |    | W  |tb|
" |---------|  | OR |---------|  | === \ |----|    |  |
" |    | W  |  |    |         |  | === / |    |    |  |
" |    |    |  |    |         |  |       |    |    |  |
" --------------    --------------       --------------
"
fun! <SID>win_occupy_vert_space(altwinbufft)
    let curwinwidth = winwidth(0)
    let curwin = winnr()
    wincmd l
    if !empty(a:altwinbufft) && a:altwinbufft != &ft
        exe curwin."wincmd w"
        return
    endif
    let altwinwidth = winwidth(0)
    exe curwin."wincmd w"
    wincmd L
    wincmd h
    wincmd L
    exe altwinwidth."wincmd |"
    wincmd h
    exe curwinwidth."wincmd |"
endfun

nmap <silent> ,U :call <SID>win_occupy_vert_space('tagbar')<CR>

" gutentags settings
let g:gutentags_exclude_filetypes = ['svn', 'cvs', 'gitcommit', 'hgcommit']
" }}}


" ---- Switching to alternative source code files {{{1
" ----
let g:UseFswitchForAlternatives = 1

if g:UseFswitchForAlternatives
    let loaded_alternateFile = 1
    nmap ,aa  :FSHere<CR>
    nmap ,as  :FSSplitAbove<CR>
    nmap ,av  :FSSplitRight<CR>
else
    let g:disable_fswitch = 1
    nmap ,aa  :A<CR>
    nmap ,as  :AS<CR>
    nmap ,av  :AV<CR>
    nmap ,at  :AT<CR>
endif

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
            \ ctermfg=244 ctermbg=229 guifg=#808080 guibg=#ffffaf
" restore FormatHints after switching to a color scheme that may clear it off
autocmd ColorScheme * highlight FormatHints term=standout
            \ ctermfg=244 ctermbg=229 guifg=#808080 guibg=#ffffaf

fun! <SID>formathints()
    if !exists("w:m1") || w:m1 == 0
        let w:m1 = matchadd('FormatHints', '\%>'.g:RightBorder.'v.\+', -1)
        let w:m2 = matchadd('FormatHints', '[\t]', -1)
        let w:m3 = matchadd('FormatHints', '[\t \r]\+$', -1)
    endif
endfun

fun! <SID>formathints_hide()
    if exists("w:m1") && w:m1 > 0
        silent! call matchdelete(w:m1)
        silent! call matchdelete(w:m2)
        silent! call matchdelete(w:m3)
        let w:m1 = 0
        let w:m2 = 0
        let w:m3 = 0
    endif
endfun

fun! <SID>doseol_hide()
    " hide ^M symbols in DOS files (they are still visible on a
    " transparent screen)
    match Ignore /\r$/
endfun

command -bar ShowFormatHints call <SID>formathints()
command -bar HideFormatHints call <SID>formathints_hide()
command      HideDosEols     call <SID>doseol_hide()

nmap <silent> ,f :if !exists("w:m1") <Bar><Bar> w:m1 == 0 <Bar>
            \ ShowFormatHints <Bar> echo "Show format hints" <Bar> else <Bar>
            \ HideFormatHints <Bar> echo "Hide format hints" <Bar> endif<CR>
nmap          ,r :HideDosEols<CR>
nmap <silent> ,m :if &colorcolumn == g:RightBorder + 1 <Bar>
            \ set colorcolumn= <Bar> elseif !&colorcolumn <Bar>
            \ exe "set colorcolumn=".(g:RightBorder + 1) <Bar> endif<CR>

" adjust colorcolumn and g:RightAlign_RightBorder when entering a buffer with
" different value of 'textwidth'
autocmd BufEnter * let g:RightBorder = &textwidth > 0 ? &textwidth : 80 |
            \ let g:RightAlign_RightBorder = g:RightBorder |
            \ if &colorcolumn |
            \ exe "setlocal colorcolumn=".(g:RightBorder + 1) |
            \ endif
" show colorcolumn when committed to svn, cvs or other VCS
autocmd FileType svn,cvs,gitcommit,hgcommit
            \ exe "setlocal colorcolumn=".(g:RightBorder + 1)
" }}}


" ---- Tagbar settings {{{1
" ----
let g:tagbar_width = 42 + &columns % 2
let g:tagbar_sort = 0

if g:DisableUnicodeSymbols
    let g:tagbar_iconchars = ['+', '-']
endif

" switch to a normal buffer when leaving a tab
autocmd TabLeave * if &filetype == 'tagbar' | wincmd p | endif

fun! <SID>vimdiff_mode()
    if exists('t:VimdiffMode')
        return t:VimdiffMode
    endif
    " check if vim runs as vimdiff using system command ps
    " (for every new tab though it is not normally necessary)
    let t:VimdiffMode = split(
                \ system( "ps -o command= -p " . getpid() ) )[0] =~ 'vimdiff'
    return t:VimdiffMode
endfun

let g:tagbar_win_ft_skip = ['fuf', 'tagbar', 'startify']

fun! <SID>open_tagbar()
    if bufwinnr('__Tagbar__') != -1
        return
    endif
    if index(g:tagbar_win_ft_skip, &filetype) != -1
        return
    endif
    if exists('t:winhidden') && exists('t:winhidden["__Tagbar__"]')
        return
    endif
    if empty(&buftype)
        setlocal buflisted
    endif
    call <SID>wintoggle_cmd('call tagbar#autoopen(0)', '__Tagbar__')
endfun

" automatically open tagbar on vim's start or a new tab is open if filetype
" of the open file is supported by ctags and tagbar (not in diff mode);
" BufWritePost shall trigger tagbar opening on the first write to a new file
autocmd FileType,BufWritePost *
            \ if !<SID>vimdiff_mode() | call <SID>open_tagbar() | endif

" setting specific ambiwidth prevents from printing garbage in the first two
" columns on the second row of the screen when tagbar automatically opens on
" vim loading (the issue was introduced in vim v8.0.0567)
set ambiwidth=single

let g:tagbar_type_haskell = {
    \ 'ctagsbin'    : 'hasktags',
    \ 'ctagsargs'   : '-x -c -o-',
    \ 'kinds'       : [
        \  'm:modules:0:1',
        \  'd:data:0:1',
        \  'd_gadt:data gadt:0:1',
        \  'nt:newtype:0:1',
        \  'c:classes:0:1',
        \  'i:instances:0:1',
        \  'cons:constructors:0:1',
        \  'c_gadt:constructor gadt:0:1',
        \  'c_a:constructor accessors:1:1',
        \  't:type names:0:1',
        \  'pt:pattern types:0:1',
        \  'pi:pattern implementations:0:1',
        \  'ft:function types:0:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'          : '.',
    \ 'kind2scope'   : {
        \ 'm'        : 'module',
        \ 'd'        : 'data',
        \ 'd_gadt'   : 'd_gadt',
        \ 'c_gadt'   : 'c_gadt',
        \ 'nt'       : 'newtype',
        \ 'cons'     : 'cons',
        \ 'c_a'      : 'accessor',
        \ 'c'        : 'class',
        \ 'i'        : 'instance'
    \ },
    \ 'scope2kind'   : {
        \ 'module'   : 'm',
        \ 'data'     : 'd',
        \ 'newtype'  : 'nt',
        \ 'cons'     : 'c_a',
        \ 'd_gadt'   : 'c_gadt',
        \ 'class'    : 'ft',
        \ 'instance' : 'ft'
    \ }
\ }
" }}}


" ---- Haskell settings {{{1
" ----
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_before_where = 4
let g:haskell_indent_in = 0
" }}}


" ---- Better mappings for plugin Mark {{{1
" ----
nmap <C-k><C-k> <Plug>MarkSet
nmap <C-k>n     <Plug>MarkClear
nmap <C-k>r     <Plug>MarkRegex
vmap <C-k><C-k> <Plug>MarkSet
vmap <C-k>r     <Plug>MarkRegex
nmap <C-k>*     <Plug>MarkSearchCurrentNext
nmap <C-k>#     <Plug>MarkSearchCurrentPrev
nmap <C-k>/     <Plug>MarkSearchAnyNext
nmap <C-k>?     <Plug>MarkSearchAnyPrev
nmap <C-k>c     <Plug>MarkAllClear
nmap <C-k>t     <Plug>MarkToggle
nmap <C-k>s     :MarkSave<CR>
nmap <C-k>l     :MarkLoad<CR>

" adjust highlight priorities between plugins Mark and Illuminate
let g:mwMaxMatchPriority = -10
let g:Illuminate_highlightPriority = -20
" }}}


" ---- System clipboard copy-paste (copy in visual mode, paste in normal) {{{1
" ----
if executable('xclip')
    vmap <C-c> y
            \ :call system('xclip -i -selection clipboard', getreg('"'))<CR>
            \ :call system('xclip -i', getreg('"'))<CR>
    nmap ,i :call setreg('"', system('xclip -o'))<CR>p
    nmap ,I :call setreg('"', system('xclip -o'))<CR>P
endif
" }}}


" ---- Context / treesitter-context and nvim_context_vt plugins settings {{{1
" ----
let g:context_enabled = 0
let g:context_nvim_no_redraw = 1
let g:context_filetype_blacklist = ['lsputil_locations_list']

lua <<EOF
  require'treesitter-context'.setup {
    enable = true,
    throttle = false,
    pin = false,
    max_lines = 0
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
  local ts_utils = require('nvim-treesitter.ts_utils')
  local min_node_size = 21
  
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
  
  require'nvim_context_vt'.setup({
    disable_ft = { 'haskell', 'vim' },
    custom_parser = function(node, _, _)
      local start_line, _, end_line, _ = ts_utils.get_node_range(node)
      if not (node:type() == 'function_definition')
              and end_line - start_line < min_node_size then
        return nil
      end
      local text = ts_utils.get_node_text(node)[1]
      if node:type() == 'function_definition' then
        local decl = find_node(node, 'function_declarator')
        if decl ~= nil then
          local start_line_decl, _, _, _ = ts_utils.get_node_range(decl)
          if start_line_decl ~= nil then
            local lines = start_line_decl - start_line
            for i = 1, lines do
              text = text .. vim.g.ContextNewlineMarker
              local next_node = ts_utils.get_node_text(node)[i + 1]
              if next_node ~= nil then
                text = text .. next_node
              end
            end
          end
        end
      else
        if not string.match(text, '%S+%s+') then
          text = text .. vim.g.ContextNewlineMarker
          local next_node = ts_utils.get_node_text(node)[2]
          if next_node ~= nil then
            text = text .. next_node
          end
        end
      end
      return vim.g.ContextTrailingMarker .. text
    end
  })
EOF
" }}}


" ---- Tablemode settings {{{1
" ----
let g:table_mode_verbose = 1
" }}}


" ---- Automatic keyboard layout switching upon entering/leaving {{{1
" ---- insert mode using xkb-switch utility and plugin xkbswitch
" ----
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchNLayout = 'us'
let g:XkbSwitchILayout = 'us'
" loading xkbswitch on BufRead when bufhidden=delete will clash xkbswitch
" function imappings_load() and plugin EnhancedJumps as soon as both will do
" redir simultaneously!
let g:XkbSwitchLoadOnBufRead = 0
let g:XkbSwitchSkipIMappings =
            \ {'c'   : ['.', '>', ':', '{<CR>', '/*', '/*<CR>'],
            \  'cpp' : ['.', '>', ':', '{<CR>', '/*', '/*<CR>']}
let g:XkbSwitchSkipFt = [ 'conque_term' ]
let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
let g:XkbSwitchAssistSKeymap = 1    " for search lines
let g:XkbSwitchDynamicKeymap = 1
let g:XkbSwitchKeymapNames = {'ru' : 'russian-jcukenwin'}

" automatic keyboard layout switching in a simple dictionary in insert mode
" (may use vimwiki or tablemode engine)
let g:mdictImpl = 'tablemode'
let g:mdictBaseColors = {'original':   [189, '#d7d7ff'],
                       \ 'translated': [194, '#d7ffd7'],
                       \ 'extra':      [191, '#d7ff5f']}

fun! <SID>mdict_syntax_set_colors(colors)
    let colors = deepcopy(a:colors)
    if exists('g:colors_name') && g:colors_name == 'lucius' &&
                \ g:lucius_style == 'light'
        let colors['original']   = [26,  '#005fd7']
        let colors['translated'] = [22,  '#005f00']
        let colors['extra']      = [167, '#d75f5f']
    endif
    exe 'hi mdictOriginalHl term=standout ctermfg='.colors['original'][0].
                \ ' guifg='.colors['original'][1]
    exe 'hi mdictTranslatedHl term=standout ctermfg='.colors['translated'][0].
                \ ' guifg='.colors['translated'][1]
    exe 'hi mdictExtraHl term=standout ctermfg='.colors['extra'][0].
                \ ' guifg='.colors['extra'][1]
endfun

fun! <SID>mdict_syntax_load()
    syntax match mdictOriginal '\(^|\)\@1<=[^|]*' containedin=Table
                \ contains=TableBorder,mdictExtra
    syntax match mdictTranslated '\(.|\)\@2<=[^|]*' containedin=Table
                \ contains=mdictExtra
    syntax match mdictExtra '([^()]*)' contained

    call <SID>mdict_syntax_set_colors(g:mdictBaseColors)
    autocmd ColorScheme * call <SID>mdict_syntax_set_colors(g:mdictBaseColors)

    hi link mdictOriginal   mdictOriginalHl
    hi link mdictTranslated mdictTranslatedHl
    hi link mdictExtra      mdictExtraHl
endfun

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
        autocmd BufNewFile,BufRead *.mdict let g:table_mode_auto_align = 0
        autocmd BufNewFile,BufRead *.mdict TableModeEnable
        autocmd BufNewFile,BufRead *.mdict call <SID>mdict_syntax_load()
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

