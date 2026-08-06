; HTML/CSS/SQL injection via comment annotation
; Supports: //lang=html  # lang=html  # html  // html

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     (string (string_content) @injection.content)))
 (#lua-match? @_comment "lang=html")
 (#set! injection.language "html")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     (string (string_content) @injection.content)))
 (#lua-match? @_comment "^[#/]+%s*html%s*$")
 (#set! injection.language "html")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     (string (string_content) @injection.content)))
 (#lua-match? @_comment "lang=css")
 (#set! injection.language "css")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     (string (string_content) @injection.content)))
 (#lua-match? @_comment "^[#/]+%s*css%s*$")
 (#set! injection.language "css")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     (string (string_content) @injection.content)))
 (#lua-match? @_comment "lang=sql")
 (#set! injection.language "sql")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     (string (string_content) @injection.content)))
 (#lua-match? @_comment "^[#/]+%s*sql%s*$")
 (#set! injection.language "sql")
 (#set! injection.combined))
