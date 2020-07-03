def Settings( **kwargs ):
    return { 'flags': [ '-x', 'c++', '-std=c++20', '-lpthread', '-I.', '-O2' ], }
