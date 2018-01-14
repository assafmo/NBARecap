#!/bin/bash
curl 'http://www.espn.com/nba/scoreboard' --compressed -s | \
grep -Po '\{"leagues.+}' | \
jq -r '.events | '\
'map(.competitions | '\
'map(.headlines | '\
'map(.video | '\
'map(if .tracking.coverageType == "Final Game Highlight" then '\
'.links.source.HD.href else empty end))))[][][][]' 2> /dev/null
