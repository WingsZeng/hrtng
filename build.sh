#!/bin/bash

set -e

BASEDIR="$(cd "$(dirname "$0")" && pwd)"

rm hrtng.so || true
git submodule update --init --recursive
mkdir -p build

pushd build || {
  echo "Failed to enter build directory"
  exit 1
}

cmake "$BASEDIR/src/" "$@"
cmake --build . --config Release -j "$(nproc)" --clean-first

popd || {
  echo "Failed to leave build directory"
  exit 1
}

ln -s build/hrtng.so .
