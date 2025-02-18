; extends

; fallback: unspecified language
(fenced_code_block
  (info_string
    (language) @label
    (#set! conceal "")))

; frequently used languages
(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "c" ".c")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "cpp" ".cpp")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "haskell" ".haskell")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "ShellSession" "shellsession" "shelloutput" ".shelloutput")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "sh" ".sh")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "nginx" ".nginx")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "vim" ".vim")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "latex" "tex" ".latex" ".tex")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "go" ".go")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "rust" ".rust")
    (#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "r" ".r")
    (#set! conceal "")))

