#!/bin/bash

nba_date=$( \
curl 'https://data.nba.net/10s/prod/v3/today.json' --compressed -s | \
jq .links.anchorDate \
)

num_of_games=$( \
curl 'https://data.nba.net/prod/v2/calendar.json' --compressed -s | \
jq ".[$nba_date]" \
)

xmls=$( \
curl 'http://www.nba.com/video/gamerecaps' -s --compressed | \
grep -Po 'collection_uuid":".+?"' | \
awk -F '"' '{print $3}' | \
xargs -I {} -n 1 curl -s --compressed https://api.nba.net/0/league/collection/{} | \
jq . | \
grep contentXml | \
awk -F '"' '{print "https://www.nba.com"$4}' | \
head -"$num_of_games" \
)

echo "$xmls" | \
xargs -n 1 curl -s --compressed | \
grep -Po 'http://nba.cdn.turner.com/nba/big/video/.+?\.mp4' | \
grep -v '["<>]' | \
grep 1080 | \
sort -u
