# NBARecap
Get links for today's NBA recaps from NBA.com and ESPN

# Installation
```bash
sudo apt install jq xargs -y
curl -sSLf https://raw.githubusercontent.com/assafmo/NBARecaph/master/nba_com_recaps.sh | sudo tee /usr/local/bin/nba_com_recaps > /dev/null
curl -sSLf https://raw.githubusercontent.com/assafmo/NBARecaph/master/espn_nba_recaps.sh | sudo tee /usr/local/bin/espn_nba_recaps > /dev/null
sudo chmod +x /usr/local/bin/espn_nba_recaps /usr/local/bin/nba_com_recaps
```

# Usage Examples
```bash
# Print today's links
espn_nba_recaps

# Print today's links
nba_com_recaps

# Download and start watching immediately (usually faster)
espn_nba_recaps | xargs -n 1 aria2c -c -s 8 -x 8 -k 1M --stream-piece-selector=inorder
nba_com_recaps | xargs -n 1 aria2c -c -s 8 -x 8 -k 1M --stream-piece-selector=inorder
```
