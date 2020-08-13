#!/usr/bin/env zsh
missing=()
for x in "$@"; do
  if ! grep -q '^declare *(strict_types *= *1);$' $x; then
    missing+=($x)
    sed -i 's/<?php/<?php declare_strict_types(true);/g' $x
  fi
done

if (( $#missing > 0 )); then
  echo "The following files had strict mode added:" 1>&2
  print -lu 2 $missing
fi
exit $#missing
