def Settings( **kwargs ):
    return { 'flags': [ '-x', 'c++', '-std=c++17', \
                       '-Weverything','-Wno-c++98-compat', '-Wno-c++98-compat-pedantic', '-Wno-pedantic', '-Wno-missing-prototypes', '-Wno-padded', '-Wno-old-style-cast', \
                       '-I.', '-Iinclude', '-O2' ], }
