#!/bin/bash

nba_date=$(
    curl 'https://data.nba.net/10s/prod/v3/today.json' -L --compressed -s |
        jq .links.anchorDate
)

num_of_games=$(
    curl 'https://data.nba.net/prod/v2/calendar.json' -L --compressed -s |
        jq ".[$nba_date]"
)

xmls=$(
    curl 'https://www.nba.com/video/gamerecaps' -L -s --compressed |
        grep -Po 'collection_uuid":".+?"' |
        awk -F '"' '{print $3}' |
        xargs -I {} -n 1 curl -L -s --compressed https://api.nba.net/0/league/collection/{} |
        jq . |
        grep contentXml |
        awk -F '"' '{print "https://www.nba.com"$4}' |
        head -"$num_of_games"
)

echo "$xmls" |
    xargs -n 1 curl -L -s --compressed |
    tr '><' '\n' |
    grep -P '.mp4$' |
    grep -F 'x1080_' |
    sort -u
