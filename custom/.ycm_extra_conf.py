def Settings( **kwargs ):
    return { 'flags': [ '-x', 'c++', '-std=c++17', '-lpthread', '-I.', '-O2' ], }
