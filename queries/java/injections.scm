; SQL injection for Spring Data @Query annotations

; @Query("SELECT ...")
((annotation
  name: (identifier) @_name
  arguments: (annotation_argument_list
    (string_literal
      (string_fragment) @injection.content)))
  (#eq? @_name "Query")
  (#set! injection.language "sql"))

; @Query(""" SELECT ... """)
((annotation
  name: (identifier) @_name
  arguments: (annotation_argument_list
    (text_block
      (string_fragment) @injection.content)))
  (#eq? @_name "Query")
  (#set! injection.language "sql"))
