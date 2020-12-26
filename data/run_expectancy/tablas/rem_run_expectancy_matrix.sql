USE baseball;

DROP TABLE rem_run_expectancy_matrix;

CREATE TABLE IF NOT EXISTS rem_run_expectancy_matrix (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  runnersBeforePlay VARCHAR(3),
  zeroOut DOUBLE,
  oneOut DOUBLE,
  twoOut DOUBLE,
  sortingOrder INTEGER
);

ALTER TABLE rem_run_expectancy_matrix ADD INDEX(majorLeagueId, seasonId);
