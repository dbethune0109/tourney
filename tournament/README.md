TOURNAMENT RESULTS PROJECT
 ## installing VIRTUAL MACHINE#

 virtual box can be obtained here(https://www.virtualbox.org/wiki/Downloads)

 vagrant can be obtained here(https://www.vagrantup.com/downloads.html)

 once both of those are installed open terminal and type
1. vagrant up
2. vagrant ssh
3. psql( this opens connection to PostgreSQL)
##database creation##
CREATE DATABASE tournament;
##connects to db
\c tournament
## Creates player table
CREATE TABLE players(
  player_id     serial  PRIMARY KEY,
  player_name   varchar
);

##Creates match table
CREATE TABLE matches(
  match_id      serial PRIMARY KEY,
  winner        integer,
  loser         integer,
  FOREIGN KEY(winner) REFERENCES players(player_id),
  FOREIGN KEY(loser) REFERENCES players(player_id)
);
## Create view for standings
CREATE VIEW standings AS
SELECT p.player_id as player_id, p.player_name,
(SELECT count(*) FROM matches WHERE matches.winner = p.player_id) as wins,
(SELECT count(*) FROM matches WHERE p.player_id in (winner, loser)) as matches
FROM players as p
GROUP BY p.player_id
ORDER BY wins DESC;


## Once that is done open second terminal window and type
'1. vagrant ssh
type python tournament_test.py and all tests will pass
