; HTML injection via comment annotation
; Supports: //lang=html  //lang=css  # html  # css  etc.

; Match: //lang=html or # lang=html (with explicit "lang=" prefix)
((comment) @_comment
 .
 (_
   [
     (string (string_value) @injection.content)
     (encapsed_string (_)* @injection.content)
   ])
 (#lua-match? @_comment "lang=html")
 (#set! injection.language "html")
 (#set! injection.combined))

((comment) @_comment
 .
 (_
   [
     (string (string_value) @injection.content)
     (encapsed_string (_)* @injection.content)
   ])
 (#lua-match? @_comment "lang=css")
 (#set! injection.language "css")
 (#set! injection.combined))

; Match: # html or // html (bare language name only)
((comment) @_comment
 .
 (_
   [
     (string (string_value) @injection.content)
     (encapsed_string (_)* @injection.content)
   ])
 (#lua-match? @_comment "^[#/]+%s*html%s*$")
 (#set! injection.language "html")
 (#set! injection.combined))

((comment) @_comment
 .
 (_
   [
     (string (string_value) @injection.content)
     (encapsed_string (_)* @injection.content)
   ])
 (#lua-match? @_comment "^[#/]+%s*css%s*$")
 (#set! injection.language "css")
 (#set! injection.combined))

; Match: //language=sql or # sql (SQL also useful in PHP)
((comment) @_comment
 .
 (_
   [
     (string (string_value) @injection.content)
     (encapsed_string (_)* @injection.content)
   ])
 (#lua-match? @_comment "lang=sql")
 (#set! injection.language "sql")
 (#set! injection.combined))

((comment) @_comment
 .
 (_
   [
     (string (string_value) @injection.content)
     (encapsed_string (_)* @injection.content)
   ])
 (#lua-match? @_comment "^[#/]+%s*sql%s*$")
 (#set! injection.language "sql")
 (#set! injection.combined))
