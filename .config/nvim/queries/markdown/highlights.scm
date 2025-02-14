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
    (#match? @label "^\.?c$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?cpp$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?haskell$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#any-of? @label "ShellSession" ".shelloutput")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?sh$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?nginx$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?vim$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?(la)?tex$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?go$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?rust$")(#set! conceal "")))

(fenced_code_block
  (info_string
    (language) @label
    (#match? @label "^\.?r$")(#set! conceal "")))

