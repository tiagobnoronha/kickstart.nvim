; SQL injection for Spring Data @Query annotations

; Single-line string: @Query("SELECT ...")
((annotation
  name: (identifier) @_name
  arguments: (annotation_argument_list
    (string_literal
      (string_fragment) @injection.content)))
  (#eq? @_name "Query")
  (#set! injection.language "sql"))

; Text block (Java 15+): @Query(""" SELECT ... """)
((annotation
  name: (identifier) @_name
  arguments: (annotation_argument_list
    (text_block
      (text_block_fragment) @injection.content)))
  (#eq? @_name "Query")
  (#set! injection.language "sql"))
