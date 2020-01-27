# V8 Library

[![Build Status](https://travis-ci.com/neogenie/v8.svg?branch=master)](https://travis-ci.com/neogenie/v8)

Base Ubuntu package `libv8-dev` doesn't contain `libplatform`. 
This image fixes this problem and allows you to perform static linking with all the necessary V8 libraries.

## Usage

```
docker pull neogenie/v8
```

V8 Libs will be available:

```
/usr/include/libplatform/libplatform-export.h
/usr/include/libplatform/libplatform.h
/usr/include/v8-inspector-protocol.h
/usr/include/v8-inspector.h
/usr/include/v8-internal.h
/usr/include/v8-platform.h
/usr/include/v8-profiler.h
/usr/include/v8-tracing.h
/usr/include/v8-util.h
/usr/include/v8-value-serializer-version.h
/usr/include/v8-version-string.h
/usr/include/v8-version.h
/usr/include/v8-wasm-trap-handler-posix.h
/usr/include/v8-wasm-trap-handler-win.h
/usr/include/v8.h
/usr/include/v8config.h

/usr/lib/libv8_libbase.a
/usr/lib/llibv8_libplatform.a
/usr/lib/llibv8_monolith.a
```

## Available images

```
docker pull neogenie/v8:ubuntu16
docker pull neogenie/v8:ubuntu18
docker pull neogenie/v8:latest # link to neogenie/v8:ubuntu18
```


