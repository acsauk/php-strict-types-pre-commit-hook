#!/usr/bin/env zsh
missing=()
for x in "$@"; do
  if ! grep -q '^declare *(strict_types *= *1);$' $x; then
    missing+=($x)
  fi
done

if (( $#missing > 0 )); then
  echo "The following files do not declare strict_types:" 1>&2
  print -lu 2 $missing
fi
exit $#missing
