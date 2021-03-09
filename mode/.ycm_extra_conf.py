def Settings( **kwargs ):
    return { 'flags': [ '-x', 'c++', '-std=c++20', '-fcoroutine-ts', '-I.', '-Iinclude'], }
