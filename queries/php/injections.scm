; extends

; HTML/CSS/SQL injection via comment annotation
; Supports: //lang=html  # lang=html  # html  // html
; Place the comment directly above a `$var = "...";` assignment or a
; `$var = match (...) { ... };` block. When the assignment's value is a
; match expression, every arm's return value is injected -- either a bare
; string/encapsed_string, or the first string/encapsed_string argument
; passed to a wrapping function call (e.g. sprintf(...), esc_html(...)).

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     [(string (string_content) @injection.content)
      (encapsed_string (string_content) @injection.content)
      (match_expression
        body: (match_block
          (_ return_expression:
            [(string (string_content) @injection.content)
             (encapsed_string (string_content) @injection.content)
             (function_call_expression
               arguments: (arguments
                 (argument [(string (string_content) @injection.content)
                            (encapsed_string (string_content) @injection.content)])))])))]))
 (#lua-match? @_comment "lang=html")
 (#set! injection.language "html")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     [(string (string_content) @injection.content)
      (encapsed_string (string_content) @injection.content)
      (match_expression
        body: (match_block
          (_ return_expression:
            [(string (string_content) @injection.content)
             (encapsed_string (string_content) @injection.content)
             (function_call_expression
               arguments: (arguments
                 (argument [(string (string_content) @injection.content)
                            (encapsed_string (string_content) @injection.content)])))])))]))
 (#lua-match? @_comment "^[#/]+%s*html%s*$")
 (#set! injection.language "html")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     [(string (string_content) @injection.content)
      (encapsed_string (string_content) @injection.content)
      (match_expression
        body: (match_block
          (_ return_expression:
            [(string (string_content) @injection.content)
             (encapsed_string (string_content) @injection.content)
             (function_call_expression
               arguments: (arguments
                 (argument [(string (string_content) @injection.content)
                            (encapsed_string (string_content) @injection.content)])))])))]))
 (#lua-match? @_comment "lang=css")
 (#set! injection.language "css")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     [(string (string_content) @injection.content)
      (encapsed_string (string_content) @injection.content)
      (match_expression
        body: (match_block
          (_ return_expression:
            [(string (string_content) @injection.content)
             (encapsed_string (string_content) @injection.content)
             (function_call_expression
               arguments: (arguments
                 (argument [(string (string_content) @injection.content)
                            (encapsed_string (string_content) @injection.content)])))])))]))
 (#lua-match? @_comment "^[#/]+%s*css%s*$")
 (#set! injection.language "css")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     [(string (string_content) @injection.content)
      (encapsed_string (string_content) @injection.content)
      (match_expression
        body: (match_block
          (_ return_expression:
            [(string (string_content) @injection.content)
             (encapsed_string (string_content) @injection.content)
             (function_call_expression
               arguments: (arguments
                 (argument [(string (string_content) @injection.content)
                            (encapsed_string (string_content) @injection.content)])))])))]))
 (#lua-match? @_comment "lang=sql")
 (#set! injection.language "sql")
 (#set! injection.combined))

((comment) @_comment
 .
 (expression_statement
   (assignment_expression
     [(string (string_content) @injection.content)
      (encapsed_string (string_content) @injection.content)
      (match_expression
        body: (match_block
          (_ return_expression:
            [(string (string_content) @injection.content)
             (encapsed_string (string_content) @injection.content)
             (function_call_expression
               arguments: (arguments
                 (argument [(string (string_content) @injection.content)
                            (encapsed_string (string_content) @injection.content)])))])))]))
 (#lua-match? @_comment "^[#/]+%s*sql%s*$")
 (#set! injection.language "sql")
 (#set! injection.combined))

; HTML/CSS/SQL injection in match expression arms via case label
; Supports: 'html' => "...", 'css' => "...", 'sql' => "...",

(match_conditional_expression
  conditional_expressions: (match_condition_list
    (string (string_content) @_lang))
  return_expression: [(string (string_content) @injection.content)
                       (encapsed_string (string_content) @injection.content)]
  (#eq? @_lang "html")
  (#set! injection.language "html")
  (#set! injection.combined))

(match_conditional_expression
  conditional_expressions: (match_condition_list
    (string (string_content) @_lang))
  return_expression: [(string (string_content) @injection.content)
                       (encapsed_string (string_content) @injection.content)]
  (#eq? @_lang "css")
  (#set! injection.language "css")
  (#set! injection.combined))

(match_conditional_expression
  conditional_expressions: (match_condition_list
    (string (string_content) @_lang))
  return_expression: [(string (string_content) @injection.content)
                       (encapsed_string (string_content) @injection.content)]
  (#eq? @_lang "sql")
  (#set! injection.language "sql")
  (#set! injection.combined))
