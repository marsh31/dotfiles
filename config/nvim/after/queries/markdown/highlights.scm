; extends

((atx_heading
  (atx_h1_marker) @_h1
  (_) @h))

((atx_heading
  (atx_h2_marker) @_h2
  (_) @h2))

((atx_heading
  (atx_h3_marker) @_h3
  (_) @h3))

((atx_heading
  (atx_h4_marker) @_h4
  (_) @h4))

((atx_heading
  (atx_h5_marker) @_h5
  (_) @h5))

(atx_heading
  (atx_h1_marker)
  (inline) @text.underline
  )

((inline) @hash.tag
          (#match? @hash.tag "#[A-Za-z0-9_]+")
 )
