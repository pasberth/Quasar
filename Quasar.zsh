#!/usr/bin/env zsh

function blackhole () {
  BLACKHOLE=t
}

function whitehole () {
  BLACKHOLE=
}

function command_not_found_handler () {
  if [[ -z $BLACKHOLE ]]; then
    return 1
  else
    echo The blackhole eats $0. 1>&2
    return 0
  fi
}

blackhole
aaaa | bb cc | hello
whitehole
ccc | xxxx ee | world
