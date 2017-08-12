#!/usr/bin/env bash

git_contributors(){
  git shortlog | grep '):' | awk '{$NF=\"\"; print $0}' | tr -d '():'
}

git_commit_count(){
  git shortlog | grep '):' | \
    awk '{printf(\"\\033[32m%s\\033[m;\"),$NF; $NF=\"\"; printf(\"\\033[37m%s\\033[m\\n\",$0)}' \
    tr -d '():' | column -s';' -t
}

delete_insert_log(){
  git log --author=$1 --shortstat $2 | \
    awk -v a="$1" -v b="$2" '/^ [0-9]/ { f += $1; i += $4; d += $6} END \
    {printf("\033[37m%s\033[m %s  f:\033[34m%d\033[m +:\033[32m%d\033[m -:\033[31m%d\033[m\n", a, b, f, i, d) }' \
    | column -s' ' -t
}
