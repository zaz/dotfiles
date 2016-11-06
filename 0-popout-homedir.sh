#!/bin/bash
pushd "${HOME}"
find ".config/homedir" -mindepth 1 -maxdepth 1 -exec ln -s '{}' . \;
popd
