USE baseball;

DROP TABLE rem_play_by_play;

CREATE TABLE IF NOT EXISTS rem_play_by_play (
  majorLeagueId int(11),
  seasonId VARCHAR(20),
  venueId int(11),
  gamePk int(11),
  inning int(11),
  halfInning VARCHAR(15),
  atBatIndex int(11),
  playIndex int(11),
  event VARCHAR(100),
  runnersBeforePlay VARCHAR(3),
  runsScoredBeforePlay int(11),
  outsBeforePlay int(11),
  runsScoredInPlay int(11),
  outsInPlay int(11),
  runsScoredAfterPlay int(11),
  outsAfterPlay int(11),
  runnersAfterPlay VARCHAR(3),
  runsScoredEndInning int(11)
);

ALTER TABLE rem_play_by_play ADD INDEX(gamePk, atBatIndex, playIndex);
