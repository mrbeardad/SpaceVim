def Settings( **kwargs ):
    return { 'flags': [ '-x', 'c++', '-std=c++20', \
                       '-Weverything','-Wno-c++98-compat', '-Wno-c++98-compat-pedantic', \
                       '-Wno-pedantic', '-Wno-missing-prototypes', '-Wno-padded', '-Wno-old-style-cast', \
                       '-Wno-exit-time-destructors', '-Wno-global-constructors',
                       '-I.', '-Iinclude', '-O2' ], }
