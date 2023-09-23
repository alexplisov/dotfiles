#!/bin/sh

find "$(pwd)/configs" -mindepth 1 -maxdepth 1 -exec ln -sf {} "$HOME/.config/" \;

