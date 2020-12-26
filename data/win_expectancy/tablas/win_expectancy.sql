USE baseball;

DROP TABLE we_win_expectancy;

CREATE TABLE IF NOT EXISTS we_win_expectancy (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  runnersBeforePlay VARCHAR(3),
  outsBeforePlay INTEGER,
  battingTeamScore INTEGER,
  win_expectancy DOUBLE
);

ALTER TABLE we_win_expectancy ADD INDEX(majorLeagueId, seasonId);
