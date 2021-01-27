def Settings( **kwargs ):
    return { 'flags': [ '-x', 'c++', '-std=c++20', '-I.', '-Iinclude', '-O2' ], }
