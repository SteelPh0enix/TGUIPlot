#!/bin/sh
mkdir -p ./build
cmake -S. -B./build/ -DCMAKE_BUILD_TYPE=Debug -DDEBUG_LOG=TRUE
cd ./build
make -j4
cd ..