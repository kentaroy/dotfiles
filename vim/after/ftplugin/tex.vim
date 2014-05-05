call textobj#user#plugin('latex', {
            \   'environment': {
            \     '*pattern*': ['\\begin{[^}]\+}.*\n\s*', '\n^\s*\\end{[^}]\+}.*$'],
            \     'select-a': 'ae',
            \     'select-i': 'ie',
            \   },
            \  'paren-math': {
            \     '*pattern*': ['\\(', '\\)'],
            \     'select-a': 'a\',
            \     'select-i': 'i\',
            \   },
            \  'dollar-math-a': {
            \     '*pattern*': '[$][^$]*[$]',
            \     'select': 'a$',
            \   },
            \  'dollar-math-i': {
            \     '*pattern*': '[$]\zs[^$]*\ze[$]',
            \     'select': 'i$',
            \   },
            \  'quote': {
            \     '*pattern*': ['`', "'"],
            \     'select-a': 'aq',
            \     'select-i': 'iq',
            \   },
            \  'double-quote': {
            \     '*pattern*': ['``', "''"],
            \     'select-a': 'aQ',
            \     'select-i': 'iQ',
            \   },
            \ })

omap iE <Plug>(textobj-latex-environment-i)
omap aE <Plug>(textobj-latex-environment-a)
vmap iE <Plug>(textobj-latex-environment-i)
vmap aE <Plug>(textobj-latex-environment-a)

omap iq <Plug>(textobj-latex-quate-i)
omap aq <Plug>(textobj-latex-quate-a)
vmap iq <Plug>(textobj-latex-quate-i)
vmap aq <Plug>(textobj-latex-quate-a)

omap iQ <Plug>(textobj-latex-double-quate-i)
omap aQ <Plug>(textobj-latex-double-quate-a)
vmap iQ <Plug>(textobj-latex-double-quate-i)
vmap aQ <Plug>(textobj-latex-double-quate-a)
