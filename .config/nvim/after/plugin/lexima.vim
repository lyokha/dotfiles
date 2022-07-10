fun! <SID>custom_lexima_rules()
    call lexima#add_rule({'char': '"',
                \ 'at': '\%#"', 'leave': 1, 'priority': 3})
    call lexima#add_rule({'char': '"',
                \ 'at': '[({[''`]\%#\<\@!\|\>\@<!\%#[)}\]''`]',
                \ 'input_after': '"', 'priority': 2})
    call lexima#add_rule({'char': '"', 'at': '\%#\S\|\S\%#', 'priority': 1})
    call lexima#add_rule({'char': "'",
                \ 'at': '\%#''', 'leave': 1, 'priority': 3})
    call lexima#add_rule({'char': "'",
                \ 'at': '[({["`]\%#\<\@!\|\>\@<!\%#[)}\]"`]',
                \ 'input_after': "'", 'priority': 2})
    call lexima#add_rule({'char': "'", 'at': '\%#\S\|\S\%#', 'priority': 1})
    call lexima#add_rule({'char': '`',
                \ 'at': '\%#`', 'leave': 1, 'priority': 3})
    call lexima#add_rule({'char': '`',
                \ 'at': '[({["'']\%#\<\@!\|\>\@<!\%#[)}\]"'']',
                \ 'input_after': '`', 'priority': 2})
    call lexima#add_rule({'char': '`', 'at': '\%#\S\|\S\%#', 'priority': 1})
endfun

let s:lexima_loaded = 0

autocmd InsertEnter * if !s:lexima_loaded |
            \ call lexima#set_default_rules() |
            \ call <SID>custom_lexima_rules() |
            \ let s:lexima_loaded = 1 |
            \ endif

