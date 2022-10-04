# The simplest Javascript runtime

## Running

```shell
make v8build
make v8

g++ -I. -I./deps/v8/include hello-world.cc -o hello_world -lv8_monolith -L./debian -pthread -std=c++14 -DV8_COMPRESS_POINTERS
g++ -I. -I./deps/v8/include shell.cc -o shell -lv8_monolith -L./debian -pthread -std=c++14 -DV8_COMPRESS_POINTERS
```

## References

- [Just JS](https://github.com/just-js)
- [Node](https://github.com/nodejs/node)
- [Getting started with embedding V8](https://v8.dev/docs/embed)