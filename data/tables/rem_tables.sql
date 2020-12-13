USE baseball;

DROP TABLE rem_play_by_play;

CREATE TABLE IF NOT EXISTS rem_play_by_play (
  majorLeagueId INTEGER,
  seasonId VARCHAR(20),
  venueId INTEGER,
  gamePk INTEGER,
  inning INTEGER,
  halfInning VARCHAR(15),
  atBatIndex INTEGER,
  playIndex INTEGER,
  event VARCHAR(100),
  runnersBeforePlay VARCHAR(3),
  runsScoredBeforePlay INTEGER,
  outsBeforePlay INTEGER,
  runsScoredInPlay INTEGER,
  outsInPlay INTEGER,
  runsScoredAfterPlay INTEGER,
  outsAfterPlay INTEGER,
  runnersAfterPlay VARCHAR(3),
  runsScoredEndInning INTEGER
);

ALTER TABLE rem_play_by_play ADD INDEX(gamePk, atBatIndex, playIndex);
