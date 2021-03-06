#!/usr/bin/env zsh
missing=()
for x in "$@"; do
  if ! grep -q '^declare *(strict_types *= *1);$' $x; then
    missing+=($x)
    ex -sc '%s/<?php/<?php declare(strict_types=1);/g' -cx $x  
  fi
done

if (( $#missing > 0 )); then
  echo "The following files had strict mode added:" 1>&2
  print -lu 2 $missing
fi
exit $#missing
