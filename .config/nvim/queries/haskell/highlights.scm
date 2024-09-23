; extends

; ### Collect items that will have higher priority than HLS semantic tokens

; consider infix functions as operators
(infix_id
  [
    (variable) @operator
    (qualified
      (variable) @operator)
  ] (#set! priority 130))

; True or False
((constructor) @boolean
  (#any-of? @boolean "True" "False") (#set! priority 130))

; otherwise (= True)
((variable) @boolean
  (#eq? @boolean "otherwise") (#set! priority 130))

; Exceptions/error handling
((variable) @keyword.exception
  (#any-of? @keyword.exception
    "error" "undefined" "try" "tryJust" "tryAny" "catch" "catches" "catchJust" "handle" "handleJust"
    "throw" "throwIO" "throwTo" "throwError" "ioError" "mask" "mask_" "uninterruptibleMask"
    "uninterruptibleMask_" "bracket" "bracket_" "bracketOnErrorSource" "finally" "fail"
    "onException" "expectationFailure") (#set! priority 130))

; Debugging
((variable) @keyword.debug
  (#any-of? @keyword.debug
    "trace" "traceId" "traceShow" "traceShowId" "traceWith" "traceShowWith" "traceStack" "traceIO"
    "traceM" "traceShowM" "traceEvent" "traceEventWith" "traceEventIO" "flushEventLog" "traceMarker"
    "traceMarkerIO") (#set! priority 130))

; render pragmas in a single color (as treesitter does now)
; (HLS highlights types and functions differently)
((pragma) @keyword.directive (#set! priority 130))

; render comments in a single color (as treesitter does now)
; (HLS highlights links to types and functions differently)
((comment) @comment (#set! priority 130))
((haddock) @comment.documentation (#set! priority 130))

; ### Various ad-hoc tweaks

; highlight opening brackets of TH quotes as a whole
("[" @keyword.quote . "|" @keyword.quote)

