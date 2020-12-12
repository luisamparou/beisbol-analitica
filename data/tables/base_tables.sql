USE baseball;

DROP TABLE players;
DROP TABLE game_player_batting_stats;
DROP TABLE game_player_fielding_stats;
DROP TABLE game_player_pitching_stats;
DROP TABLE game_batting_orders;
DROP TABLE teams;
DROP TABLE atbats;
DROP TABLE pitches;
DROP TABLE runners;
DROP TABLE game_player_positions;
DROP TABLE fielding_credits;
DROP TABLE actions;
DROP TABLE pickoffs;
DROP TABLE games;
DROP TABLE batting_orders;

CREATE TABLE batting_orders (
  gamePk INT(11),
  teamId INT(11),
  playerId INT(11),
  battingOrder INT(11)
) ENGINE = INNODB;

ALTER TABLE batting_orders ADD INDEX(teamId);

CREATE TABLE players (
  playerId INT(11),
  firstName VARCHAR(100),
  lastName VARCHAR(100),
  birthDate VARCHAR(100),
  birthCity VARCHAR(100),
  birthStateProvince VARCHAR(100),
  birthCountry VARCHAR(100),
  strikeZoneTop DOUBLE,
  strikeZoneBottom DOUBLE,
  positionAbbrev VARCHAR(10),
  batSide VARCHAR(10),
  pitchHand VARCHAR(10)
) ENGINE = INNODB;

ALTER TABLE players ADD PRIMARY KEY(playerId);

CREATE TABLE game_player_batting_stats (
  gamePk INT(11),
  teamId INT(11),
  teamType VARCHAR(10),
  playerId INT(11),
  atBats INT(11),
  walks INT(11),
  catchersInterference INT(11),
  caughtStealing INT(11),
  doubles INT(11),
  flyOuts INT(11),
  groundIntoDoublePlay INT(11),
  groundIntoTriplePlay INT(11),
  groundOuts INT(11),
  hitByPitch INT(11),
  hits INT(11),
  homeRuns INT(11),
  intentionalWalks INT(11),
  leftOnBase INT(11),
  pickoffs INT(11),
  plateAppearances INT(11),
  rbi INT(11),
  runs INT(11),
  sacBunts INT(11),
  sacFlies INT(11),
  singles INT(11),
  stolenBases INT(11),
  strikeOuts INT(11),
  totalBases INT(11),
  triples INT(11),
  unintentionalWalks INT(11)
) ENGINE = INNODB;

ALTER TABLE game_player_batting_stats ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE game_player_fielding_stats (
  gamePk INT(11),
  teamId INT(11),
  teamType VARCHAR(10),
  playerId INT(11),
  assists INT(11),
  caughtStealing INT(11),
  chances INT(11),
  errors INT(11),
  passedBall INT(11),
  pickoffs INT(11),
  putOuts INT(11),
  stolenBases INT(11)
) ENGINE = INNODB;

ALTER TABLE game_player_fielding_stats ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE game_player_pitching_stats (
  gamePk INT(11),
  teamId INT(11),
  teamType VARCHAR(10),
  playerId INT(11),
  airOuts INT(11),
  atBats INT(11),
  balls INT(11),
  walks INT(11),
  battersFaced INT(11),
  blownSaves INT(11),
  catchersInterference INT(11),
  caughtStealing INT(11),
  completeGames INT(11),
  doubles INT(11),
  earnedRuns INT(11),
  gamesFinished INT(11),
  gamesPitched INT(11),
  gamesPlayed INT(11),
  gamesStarted INT(11),
  groundOuts INT(11),
  hitBatsmen INT(11),
  hits INT(11),
  holds INT(11),
  homeRuns INT(11),
  inheritedRunners INT(11),
  inheritedRunnersScored INT(11),
  intentionalWalks INT(11),
  losses INT(11),
  numberOfPitches INT(11),
  outs INT(11),
  pickoffs INT(11),
  pitchesThrown INT(11),
  plateAppearances INT(11),
  rbi INT(11),
  runs INT(11),
  sacBunts INT(11),
  sacFlies INT(11),
  saveOpportunities INT(11),
  saves INT(11),
  singles INT(11),
  shutouts INT(11),
  stolenBases INT(11),
  strikeOuts INT(11),
  strikes INT(11),
  triples INT(11),
  unintentionalWalks INT(11),
  wildPitches INT(11),
  wins INT(11)
) ENGINE = INNODB;

ALTER TABLE game_player_pitching_stats ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE game_batting_orders (
  gamePk INT(11),
  teamId INT(11),
  playerId INT(11),
  battingOrder INT(11)
) ENGINE = INNODB;

ALTER TABLE game_batting_orders ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE teams (
  leagueId VARCHAR(10),
  divisionId INT(11),
  seasonId VARCHAR(20),
  teamId INT(11),
  venueId INT(11),
  teamAbbreviation VARCHAR(10),
  teamCode VARCHAR(10),
  teamShortName VARCHAR(100),
  teamFullName VARCHAR(100),
  teamName VARCHAR(100),
  leagueName VARCHAR(100),
  venueName VARCHAR(100),
  locationName VARCHAR(100)
) ENGINE = INNODB;

ALTER TABLE teams ADD PRIMARY KEY(leagueId, seasonId, teamId);

CREATE TABLE game_player_positions (
  gamePk INT(11),
  teamId INT(11),
  teamType VARCHAR(10),
  playerId INT(11),
  positionAbbrev VARCHAR(10)
) ENGINE = INNODB;

ALTER TABLE game_player_positions ADD INDEX(gamePk, teamId, playerId);

CREATE TABLE atbats (
  gamePk INT(11),
  inning INT(11),
  halfInning VARCHAR(15),
  atBatIndex INT(11),
  battingTeamId INT(11),
  pitchingTeamId INT(11),
  startOuts INT(11),
  endOuts INT(11),
  endBalls INT(11),
  endStrikes INT(11),
  batterId INT(11),
  pitcherId INT(11),
  hasOut TINYINT(1),
  hasReview TINYINT(1),
  isScoringPlay TINYINT(1),
  rbi INT(11),
  awayScore INT(11),
  homeScore INT(11),
  event VARCHAR(100),
  eventType VARCHAR(100),
  batSide VARCHAR(1),
  pitchHand VARCHAR(1),
  menOnBase VARCHAR(10),
  description VARCHAR(700)
) ENGINE = INNODB;

ALTER TABLE atbats ADD PRIMARY KEY(gamePk, atBatIndex);

CREATE TABLE pitches (
  gamePk INT(11),
  atBatIndex INT(11),
  playIndex INT(11),
  inning INT(11),
  halfInning VARCHAR(15),
  battingTeamId INT(11),
  pitchingTeamId INT(11),
  batterId INT(11),
  pitcherId INT(11),
  pitchNumber INT(11),
  startBalls INT(11),
  startStrikes INT(11),
  endBalls INT(11),
  endStrikes INT(11),
  callCode VARCHAR(2),
  callDescription VARCHAR(50),
  callDescription2 VARCHAR(50),
  code VARCHAR(2),
  isInPlay TINYINT(1),
  isStrike TINYINT(1),
  isBall TINYINT(1),
  typeCode VARCHAR(100),
  typeDescription VARCHAR(100),
  hasReview TINYINT(1),
  runnerGoing TINYINT(1),
  strikeZoneTop DOUBLE,
  strikeZoneBottom DOUBLE,
  x DOUBLE,
  y DOUBLE,
  x0 DOUBLE,
  y0 DOUBLE,
  trajectory VARCHAR(100),
  hardness VARCHAR(100),
  location INT(11),
  coordX DOUBLE,
  coordY DOUBLE
) ENGINE = INNODB;

ALTER TABLE pitches ADD INDEX(gamePk, atBatIndex);

CREATE TABLE runners (
  gamePk INT(11),
  inning INT(11),
  halfInning VARCHAR(15),
  pitchingTeamId INT(11),
  battingTeamId INT(11),
  atBatIndex INT(11),
  playIndex INT(11),
  event VARCHAR(100),
  eventType VARCHAR(100),
  isScoringPlay TINYINT(1),
  movementReason VARCHAR(100),
  rbi TINYINT(1),
  responsiblePitcherId INT(11),
  runnerId INT(11),
  startBase VARCHAR(10),
  endBase VARCHAR(10),
  isOut TINYINT(1),
  outBase VARCHAR(10),
  outNumber INT(11),
  earned TINYINT(1),
  teamUnearned TINYINT(1)
) ENGINE = INNODB;

ALTER TABLE runners ADD INDEX(gamePk, atBatIndex);

CREATE TABLE fielding_credits (
  gamePk INT(11),
  atBatIndex INT(11),
  playerId INT(11),
  positionAbbrev VARCHAR(10),
  credit VARCHAR(30)
) ENGINE = INNODB;

ALTER TABLE fielding_credits ADD INDEX(gamePk, atBatIndex);

CREATE TABLE actions (
  gamePk INT(11),
  inning INT(11),
  halfInning VARCHAR(15),
  pitchingTeamId INT(11),
  battingTeamId INT(11),
  atBatIndex INT(11),
  playIndex INT(11),
  playerId INT(11),
  startOuts INT(11),
  endOuts INT(11),
  startBalls INT(11),
  startStrikes INT(11),
  endBalls INT(11),
  endStrikes INT(11),
  hasReview TINYINT(1),
  isScoringPlay TINYINT(1),
  runsInPlay TINYINT(1),
  awayScore INT(11),
  homeScore INT(11),
  event VARCHAR(50),
  eventType VARCHAR(50),
  battingOrder INT(11),
  positionAbbrev VARCHAR(10),
  injuryType VARCHAR(50),
  description VARCHAR(700)
) ENGINE = INNODB;

ALTER TABLE actions ADD INDEX(gamePk, atBatIndex);

CREATE TABLE pickoffs (
  gamePk INT(11),
  atBatIndex INT(11),
  playIndex INT(11),
  outs INT(11),
  balls INT(11),
  strikes INT(11),
  fromCatcher TINYINT(1),
  hasReview TINYINT(1),
  baseCode INT(11)
) ENGINE = INNODB;

ALTER TABLE pickoffs ADD INDEX(gamePk, atBatIndex);

CREATE TABLE games (
  gamePk INT(11),
  gameType VARCHAR(10),
  gameType2 VARCHAR(10),
  seasonId VARCHAR(20),
  gameDate DATE,
  isTie TINYINT(1),
  gameNumber INT(11),
  majorLeague VARCHAR(20),
  majorLeagueId INT(11),
  doubleHeader VARCHAR(10),
  dayNight VARCHAR(10),
  scheduledInnings INT(11),
  gamesInSeries INT(11),
  seriesDescription VARCHAR(30),
  ifNecessaryDescription VARCHAR(30),
  gameId VARCHAR(30),
  abstractGameState VARCHAR(30),
  codedGameState VARCHAR(30),
  detailedState VARCHAR(30),
  awayWins INT(11),
  awayLosses INT(11),
  awayPct DOUBLE,
  awayScore INT(11),
  awayTeamId INT(11),
  awayIsWinner TINYINT(1),
  homeWins INT(11),
  homeLosses INT(11),
  homePct DOUBLE,
  homeScore INT(11),
  homeTeamId INT(11),
  homeIsWinner TINYINT(1),
  venueId INT(11),
  homeTeamName VARCHAR(100),
  awayTeamName VARCHAR(100),
  venueName VARCHAR(100)
) ENGINE = INNODB;

ALTER TABLE games ADD PRIMARY KEY(gamePk);
