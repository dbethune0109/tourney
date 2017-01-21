-- Create Database 'Tournament'
CREATE DATABASE tournament;

-- Creates player table
CREATE TABLE players(
  player_id     serial  PRIMARY KEY,
  player_name   varchar
);

-- Creates match table
CREATE TABLE matches(
  match_id      serial PRIMARY KEY,
  winner        integer,
  loser         integer,
  FOREIGN KEY(winner) REFERENCES players(player_id),
  FOREIGN KEY(loser) REFERENCES players(player_id)
);

-- Create view for standings
CREATE VIEW standings AS
SELECT p.player_id as player_id, p.player_name,
(SELECT count(*) FROM matches WHERE matches.winner = p.player_id) as wins,
(SELECT count(*) FROM matches WHERE p.player_id in (winner, loser)) as matches
FROM players as p
GROUP BY p.player_id
ORDER BY wins DESC;
