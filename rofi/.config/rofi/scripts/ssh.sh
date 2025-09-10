#!/bin/bash

export TERM=xterm-256color
ghostty -e /usr/bin/ssh -t "$@"
