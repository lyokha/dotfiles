" vim: set fdm=marker fdl=0:

" ---- Helper functions for vim-plug {{{1
" ----
fun init#ts_update()
    TSUpdate
    let mdhlscm = '/markdown/highlights.scm'
    let cfgq_mdhlscm = stdpath('config').'/queries'.mdhlscm
    let tsq_mdhlscm = g:plug_home.'/nvim-treesitter/queries'.mdhlscm
    call system('cp '.tsq_mdhlscm.' '.cfgq_mdhlscm)
    call system('sed -i ''/^(fenced_code_block$/,/^$/'.
                \ '{s/^\((.*\)/\1 (#not-normalbuf? "")/;H;'.
                \ '/^$/{x;s/(#not-\(normalbuf? "")\n\)/(#\1/;'.
                \ 's/\s*(#set! conceal_lines[^)]*)//}}'' '.cfgq_mdhlscm)
endfun
" }}}


" ---- Functions for rendering window titles {{{1
" ----
fun init#get_title_text()
    let l:showtagbar = &filetype == 'tagbar' &&
                \ (!exists('t:wintoggle_tagbar_done') ||
                \ exists('t:winhidden[t:tagbar_buf_name]'))
    let l:bufname = l:showtagbar ? bufname(winbufnr(winnr('#'))) : bufname()
    let l:icon = exists('g:StaticTitleIcon') ? g:StaticTitleIcon : ''
    if empty(l:icon)
        if &filetype == 'nerdtree'
            let l:icon = ""
        elseif &filetype == 'alpha'
            let l:icon = "󰀫"
        elseif index(["tagbar", "Outline"], &filetype) != -1 && !l:showtagbar
            let l:icon = "󰅴"
        elseif index(["Mundo", "MundoDiff"], &filetype) != -1
            let l:icon = ""
        elseif &filetype == 'TelescopePrompt'
            let l:icon = ""
        else
            let l:icon = v:lua.require'nvim-web-devicons'
                        \.get_icon(fnamemodify(l:bufname, ':t'),
                        \ fnamemodify(l:bufname, ':e'))
            if l:icon == v:null
                let l:icon = ""
            endif
        endif
    endif
    let l:text = pathshorten(l:bufname, 1)
    " NOTE: below is the Unicode En Space!
    return l:icon . ' ' . l:text
endfun

fun init#get_title_modified()
    if &filetype == 'tagbar' &&
                \ (!exists('t:wintoggle_tagbar_done') ||
                \ exists('t:winhidden[t:tagbar_buf_name]'))
        return ''
    endif
    return '%m'
endfun
" }}}


" ---- Functions for jumping to a tag under cursor in a split window {{{1
" ----
let s:TagPWinHeight = 16

fun init#open_tag(tag)
    if empty(a:tag)
        return
    endif
    let exact_tag = '^'.a:tag.'$'
    let res = taglist(exact_tag)
    if empty(res)
        echohl WarningMsg
        echo "No tag '".a:tag."' found"
        echohl None
        return
    endif
    let same_buf = res[0]['filename'] == expand('%:p')
    let tagpwin_closed = 0
    if same_buf
        exe "tag ".exact_tag
        return
    elseif &tagfunc =~ 'lsp\.tagfunc'
        let lastwin = winnr('$')
        let curwin = winnr()
        let i = 1
        " close the tag window as the tag being searched may happen
        " irrelevant in its current buffer with LSP tagfunc
        while i <= lastwin
            let pwin = getwinvar(i, 'tagpwin')
            if pwin && i != curwin
                exe "close ".i
                let tagpwin_closed = 1
                break
            endif
            let i += 1
        endwhile
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
    exe split."tag ".exact_tag
    if empty(split) && i != curwin
        " if we stay on same position then return to original window; a better
        " solution would be checking changes in tagstack but it seems to be
        " inaccessible from vim scripts
        if save_cursor == getpos('.')
            exe curwin."wincmd w"
        endif
    endif
    if split == 's' && (lastwin < winnr('$') || tagpwin_closed)
        exe s:TagPWinHeight."wincmd _"
        set winfixheight
        let w:tagpwin = 1
    endif
endfun

fun init#close_tag_win()
    let lastwin = winnr('$')
    let curwin = winnr()
    let i = 1
    while i <= lastwin
        let pwin = getwinvar(i, 'tagpwin')
        if pwin
            if i != curwin
                " treesitter-context fails to redraw correctly,
                " so close-and-open its window
                call v:lua.require'treesitter-context'.close()
                exe "close ".i
                call v:lua.require'treesitter-context'.open()
            else
                wincmd q
            endif
            break
        endif
        let i += 1
    endwhile
endfun
" }}}


" ---- Functions to setup airline {{{1
" ----
let s:airline_loaded = 0

fun init#airline_theme_patch(palette)
    if !has_key(a:palette.accents, 'red_bold')
        let a:palette.accents.red_bold = ['#d70000', '', 160, '', 'bold']
    endif
endfun

fun init#setup_airline(sudo_icon)
    if !s:airline_loaded
        " sudo indicator, this must work with both sudo -e and
        " alias svim='sudo HOME=$HOME nvim'
        call airline#parts#define('sudo', {
            \ 'text': a:sudo_icon.'SUDO',
            \ 'condition': '!empty($SUDO_USER) || $_ =~# "/sudo$"',
            \ 'accent': 'red_bold'
            \ })
        let g:airline_section_a =
                    \ airline#section#create_left(
                    \     ['mode', 'sudo', 'crypt', 'paste', 'keymap',
                    \      'spell', 'capslock', 'xkblayout', 'iminsert']
                    \ )
        AirlineRefresh
        let s:airline_loaded = 1
    endif
endfun
" }}}


" ---- Functions to setup XkbSwitchIEnterHook {{{1
" ----
highlight link BeaconNLayout Cursor
highlight BeaconOtherLayout guibg=#87ff5f ctermbg=119  " #5f00af is also good

fun s:xkb_switch_revert_beacon_highlight(id)
    highlight! link Beacon BeaconDefault
endfun

let s:HighlightIEnterHookNLayout = 1

fun init#xkb_switch_ienter_hook(old, new)
    if &ft == '_mdict_'
        return
    endif
    let nlayout = a:new == g:XkbSwitchNLayout
    if nlayout && !s:HighlightIEnterHookNLayout
        return
    endif
    let save_beacon_size = g:beacon_size
    let g:beacon_size = 20
    let beacon_bg = nlayout ? 'BeaconNLayout' : 'BeaconOtherLayout'
    exe 'highlight! link Beacon '.beacon_bg
    Beacon
    let g:beacon_size = save_beacon_size
    call timer_start(500, 's:xkb_switch_revert_beacon_highlight')
endfun
" }}}


" ---- Function to make rightmost window left to tagbar occupy all {{{1
" ---- vertical space
" ----
" --------------    --------------       --------------
" |         |tb|    |    | W  |tb|       |    | W  |tb|
" |---------|  | OR |---------|  | === \ |----|    |  |
" |    | W  |  |    |         |  | === / |    |    |  |
" |    |    |  |    |         |  |       |    |    |  |
" --------------    --------------       --------------
"
fun init#win_occupy_vert_space(altwinbufft)
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
" }}}


" ---- Functions for formatting hints highlights {{{1
" ----
fun init#formathints()
    if !exists("w:m1") || w:m1 == 0
        let w:m1 = matchadd('FormatHints', '\%>'.b:RightBorder.'v.\+', -1)
        let w:m2 = matchadd('FormatHints', '[\t]', -1)
        let w:m3 = matchadd('FormatHints', '[\t \r]\+$', -1)
    endif
endfun

fun init#formathints_hide()
    if exists("w:m1") && w:m1 > 0
        silent! call matchdelete(w:m1)
        silent! call matchdelete(w:m2)
        silent! call matchdelete(w:m3)
        let w:m1 = 0
        let w:m2 = 0
        let w:m3 = 0
    endif
endfun

fun init#doseol_hide()
    " hide ^M symbols in DOS files (they are still visible on a
    " transparent screen)
    match Ignore /\r$/
endfun
" }}}


" ---- Functions to support mdict functionality {{{1
" ----
fun s:mdict_syntax_set_colors(colors)
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

fun init#mdict_syntax_load()
    syntax match mdictOriginal '\(^|\)\@1<=[^|]*' containedin=Table
                \ contains=TableBorder,mdictExtra
    syntax match mdictTranslated '\(.|\)\@2<=[^|]*' containedin=Table
                \ contains=mdictExtra
    syntax match mdictExtra '([^()]*)' contained

    call s:mdict_syntax_set_colors(g:mdictBaseColors)
    autocmd ColorScheme * call s:mdict_syntax_set_colors(g:mdictBaseColors)

    hi link mdictOriginal   mdictOriginalHl
    hi link mdictTranslated mdictTranslatedHl
    hi link mdictExtra      mdictExtraHl
endfun
" }}}


" ---- Functions to close last ancillary buffers on quit {{{1
" ----
let s:quit_pre = 0
let s:quit_qf = 0
let s:closing_last_ancillary_buffers = 0

fun s:quit_pre_cancel(id)
    let s:quit_pre = 0
    let s:quit_qf = 0
endfun

fun init#quit_pre_hook()
    let s:quit_pre = 1
    let s:quit_qf = &filetype == 'qf'
    call timer_start(250, 's:quit_pre_cancel')
endfun

fun init#close_last_ancillary_buffers()
    if !s:quit_pre || s:quit_qf || s:closing_last_ancillary_buffers
        return
    endif
    let s:closing_last_ancillary_buffers = 1
    let quit_all = 1
    let curbuf = bufnr()
    let bufs = tabpagebuflist(tabpagenr())
    for buf in bufs
        let ft = getbufvar(buf, '&filetype')
        if buf != curbuf && getbufvar(buf, '&buflisted') && ft != 'qf'
            let quit_all = 0
            break
        endif
    endfor
    if quit_all
        for buf in bufs
            let ft = getbufvar(buf, '&filetype')
            if buf != curbuf && (!getbufvar(buf, '&buflisted') &&
                        \ index(['alpha', 'nerdtree', 'tagbar'], ft) == -1 ||
                        \ ft == 'qf')
                exe 'bdelete '.buf
            endif
        endfor
    endif
    let s:closing_last_ancillary_buffers = 0
endfun
" }}}

