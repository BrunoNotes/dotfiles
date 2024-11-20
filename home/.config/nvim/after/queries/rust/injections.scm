; extends

((let_declaration
            pattern: (identifier) @_identifier
            value: (string_literal (string_content) @injection.content)
            )
 (#contains? @_identifier "query")
 (#set! injection.language "sql")
 )

((const_item
            name: (identifier) @_identifier
            value: (string_literal (string_content) @injection.content)
            )
 (#contains? @_identifier "QUERY")
 (#set! injection.language "sql")
 )
