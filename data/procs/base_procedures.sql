USE baseball;

DROP PROCEDURE players;
DROP PROCEDURE game_player_batting_stats;
DROP PROCEDURE game_player_fielding_stats;
DROP PROCEDURE game_player_pitching_stats;
DROP PROCEDURE game_batting_orders;
DROP PROCEDURE teams;
DROP PROCEDURE game_player_positions;
DROP PROCEDURE atbats;
DROP PROCEDURE pitches;
DROP PROCEDURE runners;
DROP PROCEDURE fielding_credits;
DROP PROCEDURE actions;
DROP PROCEDURE pickoffs;
DROP PROCEDURE games;
DROP PROCEDURE batting_orders;

Delimiter //

CREATE PROCEDURE batting_orders(
) BEGIN

INSERT INTO batting_orders(
    gamePk,
    teamId,
    playerId,
    battingOrder
  )
SELECT
  gamePk,
  teamId,
  playerId,
  battingOrder
FROM s_box_team_batting_order
WHERE
  gamePk NOT IN (
    SELECT
      gamePk
    FROM batting_orders
  );

COMMIT;

END //

CREATE PROCEDURE players(
) BEGIN

INSERT INTO players(
    playerId,
    firstName,
    lastName,
    birthDate,
    birthCity,
    birthStateProvince,
    birthCountry,
    strikeZoneTop,
    strikeZoneBottom,
    positionAbbrev,
    batSide,
    pitchHand
  )
  WITH d AS (
    SELECT DISTINCT
      id playerId,
      firstName,
      lastName,
      birthDate,
      birthCity,
      birthStateProvince,
      birthCountry,
      strikeZoneTop,
      strikeZoneBottom,
      abbreviation,
      batSideCode batSide,
      pitchHandCode pitchHand
    FROM s_people
  )
SELECT
  playerId,
  firstName,
  lastName,
  birthDate,
  birthCity,
  birthStateProvince,
  birthCountry,
  strikeZoneTop,
  strikeZoneBottom,
  abbreviation,
  batSide,
  pitchHand
FROM d
WHERE
  1 = 1
  AND playerId NOT IN (
    SELECT
      playerId
    FROM players
  );
COMMIT;

END //

CREATE PROCEDURE game_player_batting_stats(
) BEGIN

INSERT INTO game_player_batting_stats(
    gamePk,
    teamId,
    teamType,
    playerId,
    atBats,
    walks,
    catchersInterference,
    caughtStealing,
    doubles,
    flyOuts,
    groundIntoDoublePlay,
    groundIntoTriplePlay,
    groundOuts,
    hitByPitch,
    hits,
    homeRuns,
    intentionalWalks,
    leftOnBase,
    pickoffs,
    rbi,
    runs,
    sacBunts,
    sacFlies,
    stolenBases,
    strikeOuts,
    totalBases,
    triples,
    singles,
    plateAppearances,
    unintentionalWalks
  )
  WITH d AS (
    SELECT
      gamePk,
      teamId,
      teamType,
      playerId,
      COALESCE(CAST(atBats AS UNSIGNED), 0) atBats,
      COALESCE(CAST(baseOnBalls AS UNSIGNED), 0) walks,
      COALESCE(CAST(catchersInterference AS UNSIGNED), 0) catchersInterference,
      COALESCE(CAST(caughtStealing AS UNSIGNED), 0) caughtStealing,
      COALESCE(CAST(doubles AS UNSIGNED), 0) doubles,
      COALESCE(CAST(flyOuts AS UNSIGNED), 0) flyOuts,
      COALESCE(CAST(groundIntoDoublePlay AS UNSIGNED), 0) groundIntoDoublePlay,
      COALESCE(CAST(groundIntoTriplePlay AS UNSIGNED), 0) groundIntoTriplePlay,
      COALESCE(CAST(groundOuts AS UNSIGNED), 0) groundOuts,
      COALESCE(CAST(hitByPitch AS UNSIGNED), 0) hitByPitch,
      COALESCE(CAST(hits AS UNSIGNED), 0) hits,
      COALESCE(CAST(homeRuns AS UNSIGNED), 0) homeRuns,
      COALESCE(CAST(intentionalWalks AS UNSIGNED), 0) intentionalWalks,
      COALESCE(CAST(leftOnBase AS UNSIGNED), 0) leftOnBase,
      COALESCE(CAST(pickoffs AS UNSIGNED), 0) pickoffs,
      COALESCE(CAST(rbi AS UNSIGNED), 0) rbi,
      COALESCE(CAST(runs AS UNSIGNED), 0) runs,
      COALESCE(CAST(sacBunts AS UNSIGNED), 0) sacBunts,
      COALESCE(CAST(sacFlies AS UNSIGNED), 0) sacFlies,
      COALESCE(CAST(stolenBases AS UNSIGNED), 0) stolenBases,
      COALESCE(CAST(strikeOuts AS UNSIGNED), 0) strikeOuts,
      COALESCE(CAST(totalBases AS UNSIGNED), 0) totalBases,
      COALESCE(CAST(triples AS UNSIGNED), 0) triples,
      COALESCE(CAST(hits AS UNSIGNED), 0) - COALESCE(CAST(homeRuns AS UNSIGNED), 0) - COALESCE(
        CAST(doubles AS UNSIGNED),
        0
      ) - COALESCE(CAST(triples AS UNSIGNED), 0) singles,
      COALESCE(CAST(atBats AS UNSIGNED), 0) + COALESCE(CAST(sacBunts AS UNSIGNED), 0) + COALESCE(
        CAST(sacFlies AS UNSIGNED),
        0
      ) + COALESCE(CAST(baseOnBalls AS UNSIGNED), 0) + COALESCE(
        CAST(hitByPitch AS UNSIGNED),
        0
      ) plateAppearances,
      COALESCE(CAST(baseOnBalls AS UNSIGNED), 0) - COALESCE(
        CAST(intentionalWalks AS UNSIGNED),
        0
      ) unintentionalWalks
    FROM s_box_player_batting
    WHERE
      1 = 1
      AND (
        atBats > 0
        OR baseOnBalls > 0
        OR catchersInterference > 0
        OR caughtStealing > 0
        OR doubles > 0
        OR flyOuts > 0
        OR groundIntoDoublePlay > 0
        OR groundIntoTriplePlay > 0
        OR groundOuts > 0
        OR hitByPitch > 0
        OR hits > 0
        OR homeRuns > 0
        OR intentionalWalks > 0
        OR leftOnBase > 0
        OR pickoffs > 0
        OR rbi > 0
        OR runs > 0
        OR sacBunts > 0
        OR sacFlies > 0
        OR stolenBases > 0
        OR strikeOuts > 0
        OR totalBases > 0
        OR triples > 0
      )
  )
SELECT
  gamePk,
  teamId,
  teamType,
  playerId,
  atBats,
  walks,
  catchersInterference,
  caughtStealing,
  doubles,
  flyOuts,
  groundIntoDoublePlay,
  groundIntoTriplePlay,
  groundOuts,
  hitByPitch,
  hits,
  homeRuns,
  intentionalWalks,
  leftOnBase,
  pickoffs,
  rbi,
  runs,
  sacBunts,
  sacFlies,
  stolenBases,
  strikeOuts,
  totalBases,
  triples,
  singles,
  plateAppearances,
  unintentionalWalks
FROM d
WHERE
  1 = 1
  AND (gamePk, teamId, playerId) NOT IN (
    SELECT
      gamePk,
      teamId,
      playerId
    FROM game_player_batting_stats
  );

COMMIT;

END //

CREATE PROCEDURE game_player_fielding_stats(
) BEGIN

INSERT INTO game_player_fielding_stats(
    gamePk,
    teamId,
    teamType,
    playerId,
    assists,
    caughtStealing,
    chances,
    errors,
    passedBall,
    pickoffs,
    putOuts,
    stolenBases
  )
  WITH d AS (
    SELECT
      gamePk,
      teamId,
      teamType,
      playerId,
      COALESCE(CAST(assists AS UNSIGNED), 0) assists,
      COALESCE(CAST(caughtStealing AS UNSIGNED), 0) caughtStealing,
      COALESCE(CAST(chances AS UNSIGNED), 0) chances,
      COALESCE(CAST(errors AS UNSIGNED), 0) errors,
      COALESCE(CAST(passedBall AS UNSIGNED), 0) passedBall,
      COALESCE(CAST(pickoffs AS UNSIGNED), 0) pickoffs,
      COALESCE(CAST(putOuts AS UNSIGNED), 0) putOuts,
      COALESCE(CAST(stolenBases AS UNSIGNED), 0) stolenBases
    FROM s_box_player_fielding
    WHERE
      1 = 1
      AND (
        COALESCE(CAST(assists AS UNSIGNED), 0) > 0
        OR COALESCE(CAST(caughtStealing AS UNSIGNED), 0) > 0
        OR COALESCE(CAST(chances AS UNSIGNED), 0) > 0
        OR COALESCE(CAST(errors AS UNSIGNED), 0) > 0
        OR COALESCE(CAST(passedBall AS UNSIGNED), 0) > 0
        OR COALESCE(CAST(pickoffs AS UNSIGNED), 0) > 0
        OR COALESCE(CAST(putOuts AS UNSIGNED), 0) > 0
        OR COALESCE(CAST(stolenBases AS UNSIGNED), 0) > 0
      )
  )
SELECT
  gamePk,
  teamId,
  teamType,
  playerId,
  assists,
  caughtStealing,
  chances,
  errors,
  passedBall,
  pickoffs,
  putOuts,
  stolenBases
FROM d
WHERE
  1 = 1
  AND (gamePk, teamId, playerId) NOT IN (
    SELECT
      gamePk,
      teamId,
      playerId
    FROM game_player_fielding_stats
  );

COMMIT;

END //

CREATE PROCEDURE game_player_pitching_stats(
) BEGIN

INSERT INTO game_player_pitching_stats(
    gamePk,
    teamId,
    teamType,
    playerId,
    airOuts,
    atBats,
    balls,
    walks,
    battersFaced,
    blownSaves,
    catchersInterference,
    caughtStealing,
    completeGames,
    doubles,
    earnedRuns,
    gamesFinished,
    gamesPitched,
    gamesPlayed,
    gamesStarted,
    groundOuts,
    hitBatsmen,
    hits,
    holds,
    homeRuns,
    inheritedRunners,
    inheritedRunnersScored,
    intentionalWalks,
    losses,
    numberOfPitches,
    outs,
    pickoffs,
    pitchesThrown,
    rbi,
    runs,
    sacBunts,
    sacFlies,
    saveOpportunities,
    saves,
    shutouts,
    stolenBases,
    strikeOuts,
    strikes,
    triples,
    wildPitches,
    wins,
    singles,
    plateAppearances,
    unintentionalWalks
  )
  WITH d AS (
    SELECT
      gamePk,
      teamId,
      teamType,
      playerId,
      COALESCE(CAST(airOuts AS UNSIGNED), 0) airOuts,
      COALESCE(CAST(atBats AS UNSIGNED), 0) atBats,
      COALESCE(CAST(balls AS UNSIGNED), 0) balls,
      COALESCE(CAST(baseOnBalls AS UNSIGNED), 0) walks,
      COALESCE(CAST(battersFaced AS UNSIGNED), 0) battersFaced,
      COALESCE(CAST(blownSaves AS UNSIGNED), 0) blownSaves,
      COALESCE(CAST(catchersInterference AS UNSIGNED), 0) catchersInterference,
      COALESCE(CAST(caughtStealing AS UNSIGNED), 0) caughtStealing,
      COALESCE(CAST(completeGames AS UNSIGNED), 0) completeGames,
      COALESCE(CAST(doubles AS UNSIGNED), 0) doubles,
      COALESCE(CAST(earnedRuns AS UNSIGNED), 0) earnedRuns,
      COALESCE(CAST(gamesFinished AS UNSIGNED), 0) gamesFinished,
      COALESCE(CAST(gamesPitched AS UNSIGNED), 0) gamesPitched,
      COALESCE(CAST(gamesPlayed AS UNSIGNED), 0) gamesPlayed,
      COALESCE(CAST(gamesStarted AS UNSIGNED), 0) gamesStarted,
      COALESCE(CAST(groundOuts AS UNSIGNED), 0) groundOuts,
      COALESCE(CAST(hitBatsmen AS UNSIGNED), 0) hitBatsmen,
      COALESCE(CAST(hits AS UNSIGNED), 0) hits,
      COALESCE(CAST(holds AS UNSIGNED), 0) holds,
      COALESCE(CAST(homeRuns AS UNSIGNED), 0) homeRuns,
      COALESCE(CAST(inheritedRunners AS UNSIGNED), 0) inheritedRunners,
      COALESCE(CAST(inheritedRunnersScored AS UNSIGNED), 0) inheritedRunnersScored,
      COALESCE(CAST(intentionalWalks AS UNSIGNED), 0) intentionalWalks,
      COALESCE(CAST(losses AS UNSIGNED), 0) losses,
      COALESCE(CAST(numberOfPitches AS UNSIGNED), 0) numberOfPitches,
      COALESCE(CAST(outs AS UNSIGNED), 0) outs,
      COALESCE(CAST(pickoffs AS UNSIGNED), 0) pickoffs,
      COALESCE(CAST(pitchesThrown AS UNSIGNED), 0) pitchesThrown,
      COALESCE(CAST(rbi AS UNSIGNED), 0) rbi,
      COALESCE(CAST(runs AS UNSIGNED), 0) runs,
      COALESCE(CAST(sacBunts AS UNSIGNED), 0) sacBunts,
      COALESCE(CAST(sacFlies AS UNSIGNED), 0) sacFlies,
      COALESCE(CAST(saveOpportunities AS UNSIGNED), 0) saveOpportunities,
      COALESCE(CAST(saves AS UNSIGNED), 0) saves,
      COALESCE(CAST(shutouts AS UNSIGNED), 0) shutouts,
      COALESCE(CAST(stolenBases AS UNSIGNED), 0) stolenBases,
      COALESCE(CAST(strikeOuts AS UNSIGNED), 0) strikeOuts,
      COALESCE(CAST(strikes AS UNSIGNED), 0) strikes,
      COALESCE(CAST(triples AS UNSIGNED), 0) triples,
      COALESCE(CAST(wildPitches AS UNSIGNED), 0) wildPitches,
      COALESCE(CAST(wins AS UNSIGNED), 0) wins,
      COALESCE(CAST(hits AS UNSIGNED), 0) - COALESCE(CAST(homeRuns AS UNSIGNED), 0) - COALESCE(
        CAST(doubles AS UNSIGNED),
        0
      ) - COALESCE(CAST(triples AS UNSIGNED), 0) singles,
      COALESCE(CAST(atBats AS UNSIGNED), 0) + COALESCE(CAST(sacBunts AS UNSIGNED), 0) + COALESCE(
        CAST(sacFlies AS UNSIGNED),
        0
      ) + COALESCE(CAST(baseOnBalls AS UNSIGNED), 0) + COALESCE(
        CAST(hitBatsmen AS UNSIGNED),
        0
      ) plateAppearances,
      COALESCE(CAST(baseOnBalls AS UNSIGNED), 0) - COALESCE(
        CAST(intentionalWalks AS UNSIGNED),
        0
      ) unintentionalWalks
    FROM s_box_player_pitching
    WHERE
      1 = 1
      AND (
        airOuts > 0
        OR atBats > 0
        OR balls > 0
        OR baseOnBalls > 0
        OR battersFaced > 0
        OR blownSaves > 0
        OR catchersInterference > 0
        OR caughtStealing > 0
        OR completeGames > 0
        OR doubles > 0
        OR earnedRuns > 0
        OR gamesFinished > 0
        OR gamesPitched > 0
        OR gamesPlayed > 0
        OR gamesStarted > 0
        OR groundOuts > 0
        OR hitBatsmen > 0
        OR hits > 0
        OR holds > 0
        OR homeRuns > 0
        OR inheritedRunners > 0
        OR inheritedRunnersScored > 0
        OR intentionalWalks > 0
        OR losses > 0
        OR numberOfPitches > 0
        OR outs > 0
        OR pickoffs > 0
        OR pitchesThrown > 0
        OR rbi > 0
        OR runs > 0
        OR sacBunts > 0
        OR sacFlies > 0
        OR saveOpportunities > 0
        OR saves > 0
        OR shutouts > 0
        OR stolenBases > 0
        OR strikeOuts > 0
        OR strikes > 0
        OR triples > 0
        OR wildPitches > 0
        OR wins > 0
      )
  )
SELECT
  gamePk,
  teamId,
  teamType,
  playerId,
  airOuts,
  atBats,
  balls,
  walks,
  battersFaced,
  blownSaves,
  catchersInterference,
  caughtStealing,
  completeGames,
  doubles,
  earnedRuns,
  gamesFinished,
  gamesPitched,
  gamesPlayed,
  gamesStarted,
  groundOuts,
  hitBatsmen,
  hits,
  holds,
  homeRuns,
  inheritedRunners,
  inheritedRunnersScored,
  intentionalWalks,
  losses,
  numberOfPitches,
  outs,
  pickoffs,
  pitchesThrown,
  rbi,
  runs,
  sacBunts,
  sacFlies,
  saveOpportunities,
  saves,
  shutouts,
  stolenBases,
  strikeOuts,
  strikes,
  triples,
  wildPitches,
  wins,
  singles,
  plateAppearances,
  unintentionalWalks
FROM d
WHERE
  1 = 1
  AND (gamePk, teamId, playerId) NOT IN (
    SELECT
      gamePk,
      teamId,
      playerId
    FROM game_player_pitching_stats
  );
COMMIT;

END //

CREATE PROCEDURE game_batting_orders(
) BEGIN

INSERT INTO game_batting_orders(
    gamePk,
    teamId,
    playerId,
    battingOrder
  )
  WITH d AS (
    SELECT
      gamePk,
      teamId,
      playerId,
      battingOrder
    FROM s_box_team_batting_order
  )
SELECT
  gamePk,
  teamId,
  playerId,
  battingOrder
FROM d
WHERE
  1 = 1
  AND (gamePk, teamId, playerId) NOT IN (
    SELECT
      gamePk,
      teamId,
      playerId
    FROM game_batting_orders
  );
COMMIT;

END //

CREATE PROCEDURE teams(
) BEGIN

INSERT INTO teams(
    leagueId,
    divisionId,
    seasonId,
    teamId,
    teamAbbreviation,
    teamCode,
    teamShortName,
    teamFullName,
    teamName,
    leagueName,
    venueId,
    venueName,
    locationName
  )
  WITH d AS (
    SELECT DISTINCT
      leagueID,
      divisionId,
      COALESCE(season, 0) seasonId,
      id AS teamId,
      abbreviation teamAbbreviation,
      /* Problema con la temporada 2019 de LBPRC y LIDOM */
      CASE
        WHEN season = 2019 AND teamName = 'Santurce' THEN 'Santurce'
        WHEN locationName = 'Santo Dominigo' THEN 'Santo Domingo'
        ELSE locationName
      END locationName,
      shortName teamShortName,
      name teamFullName,
      teamCode,
      teamName,
      leagueName,
      venueId,
      venueName
    FROM s_box_team
  )
SELECT
  leagueId,
  divisionId,
  seasonId,
  teamId,
  teamAbbreviation,
  teamCode,
  teamShortName,
  teamFullName,
  teamName,
  leagueName,
  venueId,
  venueName,
  locationName
FROM d
WHERE
  1 = 1
  AND (leagueId, COALESCE(seasonId, 0), teamId) NOT IN (
    SELECT
      leagueId,
      seasonId,
      teamId
    FROM teams
  );

COMMIT;

END //

CREATE PROCEDURE game_player_positions(
) BEGIN

INSERT INTO game_player_positions(
    gamePk,
    teamId,
    teamType,
    playerId,
    positionAbbrev
  )
  WITH d AS (
    SELECT
      gamePk,
      teamId,
      teamType,
      playerId,
      abbreviation positionAbbrev
    FROM baseball.s_box_player_game_positions
  )
SELECT
  gamePk,
  teamId,
  teamType,
  playerId,
  positionAbbrev
FROM d
WHERE
  1 = 1
  AND (gamePk, teamId, playerId) NOT IN (
    SELECT
      gamePk,
      teamId,
      playerId
    FROM game_player_positions
  );

COMMIT;

END //

CREATE PROCEDURE atbats(
) BEGIN

INSERT INTO atbats(
    gamePk,
    inning,
    halfInning,
    atBatIndex,
    endOuts,
    endBalls,
    endStrikes,
    batterId,
    pitcherId,
    hasOut,
    hasReview,
    isScoringPlay,
    rbi,
    awayScore,
    homeScore,
    event,
    eventType,
    batSide,
    pitchHand,
    description
  )
  WITH d AS (
    SELECT
      gamePk,
      inning,
      halfInning,
      atBatIndex,
      outs AS endOuts,
      balls AS endBalls,
      strikes AS endStrikes,
      batterId,
      pitcherId,
      hasOut,
      hasReview,
      isScoringPlay,
      rbi,
      awayScore,
      homeScore,
      event,
      eventType,
      batterSideCode batSide,
      pitcherHandCode pitchHand,
      description
    FROM s_play_atbat
  )
SELECT
  gamePk,
  inning,
  halfInning,
  atBatIndex,
  endOuts,
  endBalls,
  endStrikes,
  batterId,
  pitcherId,
  hasOut,
  hasReview,
  isScoringPlay,
  rbi,
  awayScore,
  homeScore,
  event,
  eventType,
  batSide,
  pitchHand,
  description
FROM d
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM atbats
  );
-- Update batting/pitching teams
UPDATE
  atbats a
INNER JOIN (
  SELECT
    gamePk,
    homeTeamId,
    awayTeamId
  FROM games g
) q
  ON (a.gamePk = q.gamePk)
  SET a.pitchingTeamId = If( a.halfInning = 'top', homeTeamId, awayTeamId )
  ,   a.battingTeamId  = If( a.halfInning = 'top', awayTeamId, homeTeamId )
  Where 1 = 1
  And   ( pitchingTeamId Is Null Or battingTeamId Is Null );

-- startOuts
UPDATE
  atbats a
LEFT JOIN (
  SELECT
    gamePk,
    atBatIndex,
    inning,
    halfInning,
    endOuts
  FROM atbats
) a2
  ON (
    a.gamePk = a2.gamePk
    AND a.inning = a2.inning
    AND a.halfInning = a2.halfInning
    AND a.atBatIndex - 1 = a2.atBatIndex
  )
  SET a.startouts = Coalesce( a2.endOuts, 0 )
  Where 1 = 1
  And a.startOuts Is Null
;

COMMIT;

END //

CREATE PROCEDURE pitches(
) BEGIN

INSERT INTO pitches(
    gamePk,
    atBatIndex,
    playIndex,
    pitchNumber,
    endBalls,
    endStrikes,
    callCode,
    callDescription,
    callDescription2,
    code,
    isInPlay,
    isStrike,
    isBall,
    typeCode,
    typeDescription,
    hasReview,
    runnerGoing,
    strikeZoneTop,
    strikeZoneBottom,
    x,
    y,
    x0,
    y0,
    trajectory,
    hardness,
    location,
    coordX,
    coordY
  )
  WITH d AS (
    SELECT
      gamePk,
      atBatIndex,
      `index` playIndex,
      pitchNumber,
      balls AS endBalls,
      strikes AS endStrikes,
      callCode,
      callDescription,
      description callDescription2,
      code,
      isInPlay,
      isStrike,
      isBall,
      typeCode,
      typeDescription,
      hasReview,
      runnerGoing,
      strikeZoneTop,
      strikeZoneBottom,
      x,
      y,
      x0,
      y0,
      trajectory,
      hardness,
      location,
      coordX,
      coordY
    FROM s_play_pitch
  )
SELECT
  gamePk,
  atBatIndex,
  playIndex,
  pitchNumber,
  endBalls,
  endStrikes,
  callCode,
  callDescription,
  callDescription2,
  code,
  isInPlay,
  isStrike,
  isBall,
  typeCode,
  typeDescription,
  hasReview,
  runnerGoing,
  strikeZoneTop,
  strikeZoneBottom,
  x,
  y,
  x0,
  y0,
  trajectory,
  hardness,
  location,
  coordX,
  coordY
FROM d
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM pitches
  );

-- Update batting/pitching ids
UPDATE
  pitches p
INNER JOIN (
  SELECT
    gamePk,
    atBatIndex,
    inning,
    halfInning,
    pitchingTeamId,
    battingTeamId,
    batterId,
    pitcherId
  FROM atbats
  WHERE
    1 = 1
) q
  ON (
    p.gamePk = q.gamePk
    AND p.atBatIndex = q.atBatIndex
  )
  SET p.pitchingTeamId = q.pitchingTeamId
  ,   p.battingTeamId  = q.battingTeamId
  ,   p.inning         = q.inning
  ,   p.halfInning     = q.halfInning
  ,   p.batterId       = q.batterId
  ,   p.pitcherId      = q.pitcherId
  Where 1 = 1
  And   ( p.pitchingTeamId Is Null Or p.battingTeamId Is Null );

UPDATE
  pitches p
LEFT JOIN (
  SELECT
    gamePk,
    atBatIndex,
    pitchNumber,
    endBalls,
    endStrikes
  FROM pitches
  WHERE
    1 = 1
) q
  ON (
    p.gamePk = q.gamePk
    AND p.atBatIndex = q.atBatIndex
    AND p.pitchNumber - 1 = q.pitchNumber
  )
  SET  p.startBalls   = Coalesce( q.endBalls, 0 )
  ,    p.startStrikes = Coalesce( q.endStrikes, 0 )
  Where 1 = 1
  And   ( p.startBalls Is Null Or p.startStrikes Is Null );

COMMIT;

END //

CREATE PROCEDURE runners(
) BEGIN

INSERT INTO runners(
    gamePk,
    atBatIndex,
    playIndex,
    event,
    eventType,
    isScoringPlay,
    movementReason,
    rbi,
    responsiblePitcherId,
    runnerId,
    start,
  END,
  isOut,
  outBase,
  outNumber,
  earned,
  teamUnearned
)
WITH d AS (
  SELECT
    gamePk,
    atBatIndex,
    playIndex,
    event,
    eventType,
    isScoringEvent isScoringPlay,
    movementReason,
    rbi,
    CAST(responsiblePitcherId AS UNSIGNED) responsiblePitcherId,
    runnerId,
    start,
END,
isOut,
outBase,
CAST(outNumber AS UNSIGNED) outNumber,
earned,
teamUnearned
FROM s_play_runner
WHERE
  1 = 1
  AND outNumber != -1
)
SELECT
  gamePk,
  atBatIndex,
  playIndex,
  event,
  eventType,
  isScoringPlay,
  movementReason,
  rbi,
  responsiblePitcherId,
  runnerId,
  start,
END,
isOut,
outBase,
outNumber,
earned,
teamUnearned
FROM d
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM runners
  );

UPDATE
  runners p
INNER JOIN (
  SELECT
    gamePk,
    atBatIndex,
    inning,
    halfInning,
    pitchingTeamId,
    battingTeamId
  FROM atbats
  WHERE
    1 = 1
) q
  ON (
    p.gamePk = q.gamePk
    AND p.atBatIndex = q.atBatIndex
  )
  SET p.pitchingTeamId = q.pitchingTeamId
  ,   p.battingTeamId  = q.battingTeamId
  ,   p.inning         = q.inning
  ,   p.halfInning     = q.halfInning
  Where 1 = 1
  And   ( p.pitchingTeamId Is Null Or p.battingTeamId Is Null );

COMMIT;

END //

CREATE PROCEDURE fielding_credits(
) BEGIN

INSERT INTO fielding_credits(
    gamePk,
    atBatIndex,
    playerId,
    positionAbbrev,
    credit
  )
  WITH d AS (
    SELECT
      gamePk,
      atBatIndex,
      playerId,
      abbreviation positionAbbrev,
      credit
    FROM s_play_credit
  )
SELECT
  gamePk,
  atBatIndex,
  playerId,
  positionAbbrev,
  credit
FROM d
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM fielding_credits
  );

COMMIT;

END //

CREATE PROCEDURE actions(
) BEGIN

INSERT INTO actions(
    gamePk,
    atBatIndex,
    playIndex,
    playerId,
    endOuts,
    endBalls,
    endStrikes,
    hasReview,
    isScoringPlay,
    awayScore,
    homeScore,
    event,
    eventType,
    battingOrder,
    positionAbbrev,
    injuryType,
    description
  )
  WITH d AS (
    SELECT
      gamePk,
      atBatIndex,
      `index` playIndex,
      playerId,
      outs AS endOuts,
      balls AS endBalls,
      strikes AS endStrikes,
      hasReview,
      isScoringPlay,
      awayScore,
      homeScore,
      event,
      eventType,
      battingOrder,
      abbreviation positionAbbrev,
      injuryType,
      description
    FROM s_play_action
  )
SELECT
  gamePk,
  atBatIndex,
  playIndex,
  playerId,
  endOuts,
  endBalls,
  endStrikes,
  hasReview,
  isScoringPlay,
  awayScore,
  homeScore,
  event,
  eventType,
  battingOrder,
  positionAbbrev,
  injuryType,
  description
FROM d
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM actions
  );

-- actions
UPDATE
  actions p
INNER JOIN (
  SELECT
    gamePk,
    atBatIndex,
    inning,
    halfInning,
    pitchingTeamId,
    battingTeamId
  FROM atbats
  WHERE
    1 = 1
) q
  ON (
    p.gamePk = q.gamePk
    AND p.atBatIndex = q.atBatIndex
  )
  SET p.pitchingTeamId = q.pitchingTeamId
  ,   p.battingTeamId  = q.battingTeamId
  ,   p.inning         = q.inning
  ,   p.halfInning     = q.halfInning
  Where 1 = 1
  And   ( p.pitchingTeamId Is Null Or p.battingTeamId Is Null );

-- startBalls, startStrikes
WITH actionIndexes AS (
  SELECT
    a.gamePk,
    a.atBatIndex,
    a.playIndex actionPlayIndex,
    COALESCE(MAX(p.startBalls), 0) startBalls,
    COALESCE(MAX(p.startStrikes), 0) startStrikes
  FROM actions a
  LEFT JOIN (pitches p)
    ON (
      a.gamePk = p.gamePk
      AND a.atBatIndex = p.atBatIndex
      AND a.playIndex > p.playIndex
    )
  GROUP BY
    a.gamePk,
    a.atBatIndex,
    a.playIndex
)
UPDATE
  actions a
INNER JOIN actionIndexes ai
  ON (
    a.gamePk = ai.gamePk
    AND a.atBatIndex = ai.atBatIndex
    AND a.playIndex = ai.actionPlayIndex
  )
  SET  a.startBalls   = ai.startBalls
  ,    a.startStrikes = ai.startStrikes
  Where 1 = 1
  And ( a.startBalls Is Null Or a.startStrikes Is Null );

-- start outs
WITH actionIndexes AS (
  SELECT
    a.gamePk,
    a.atBatIndex,
    a.playIndex,
    MAX(a2.endOuts) endOuts
  FROM actions a
  LEFT JOIN actions a2
    ON (
      a.gamePk = a2.gamePk
      AND a.atBatIndex = a2.atBatIndex
      AND a.playIndex > a2.playIndex
    )
  GROUP BY
    a.gamePk,
    a.atBatIndex,
    a.playIndex
),
actionIndexes2 AS (
  SELECT
    a2.gamePk,
    a2.atBatIndex,
    a2.playIndex,
    COALESCE(a2.endOuts, a.startOuts) startOuts
  FROM actionIndexes a2
  LEFT JOIN (atbats a)
    ON (
      a2.gamePk = a.gamePk
      AND a2.atBatIndex = a.atBatIndex
    )
)
UPDATE
  actions a
INNER JOIN actionIndexes2 a2
  ON (
    a.gamePk = a2.gamePk
    AND a.atBatIndex = a2.atBatIndex
    AND a.playIndex = a2.playIndex
  )
  SET a.startOuts = a2.startOuts
  Where a.startOuts Is Null;

-- runs in play
UPDATE
  actions a
INNER JOIN (
    WITH d AS (
      SELECT
        gamePk,
        atBatIndex,
        playIndex,
        CAST(
          (LENGTH(description) - LENGTH(REPLACE(description, 'scores', ''))) / 6 AS UNSIGNED
        ) scores,
        CASE
          WHEN REPLACE(description, ',', '.') LIKE '% steals % home.%' THEN 1
          ELSE 0
        END stealing
      FROM actions
      WHERE
        isScoringPlay = TRUE
        AND event NOT IN (
          'Defensive Switch',
          'Defensive Sub',
          'Injury',
          'Offensive Substitution',
          'Defensive Indiff',
          'Ejection',
          'Pitch Challenge',
          'Game Advisory',
          'Other Advance',
          'Pitching Substitution',
          'Umpire Substitution'
        )
    )
    SELECT
      gamePk,
      atBatIndex,
      playIndex,
      scores + stealing runsInPlay
    FROM d
  ) q
  ON (
    a.gamePk = q.gamePk
    AND a.atBatIndex = q.atBatIndex
    AND a.playIndex = q.playIndex
  )
  SET a.runsInPlay = q.runsInPlay;

COMMIT;

END //

CREATE PROCEDURE pickoffs(
) BEGIN

INSERT INTO pickoffs(
    gamePk,
    atBatIndex,
    playIndex,
    outs,
    balls,
    strikes,
    fromCatcher,
    hasReview,
    baseCode
  )
  WITH d AS (
    SELECT
      gamePk,
      atBatIndex,
      `index` playIndex,
      outs,
      balls,
      strikes,
      fromCatcher,
      hasReview,
      code baseCode
    FROM s_play_pickoff
  )
SELECT
  gamePk,
  atBatIndex,
  playIndex,
  outs,
  balls,
  strikes,
  fromCatcher,
  hasReview,
  baseCode
FROM d
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM pickoffs
  );

COMMIT;

END //

CREATE PROCEDURE games(
) BEGIN

INSERT INTO games(
    gamePk,
    gameType,
    seasonId,
    gameDate,
    isTie,
    gameNumber,
    doubleHeader,
    dayNight,
    scheduledInnings,
    gamesInSeries,
    seriesDescription,
    ifNecessaryDescription,
    gameId,
    abstractGameState,
    codedGameState,
    detailedState,
    awayWins,
    awayLosses,
    awayPct,
    awayScore,
    awayTeamId,
    awayIsWinner,
    homeWins,
    homeLosses,
    homePct,
    homeScore,
    homeTeamId,
    homeIsWinner,
    venueId,
    homeTeamName,
    awayTeamName,
    venueName,
    majorLeague,
    majorLeagueId,
    gameType2
  )
  WITH d AS (
    SELECT
      gamePk,
      gameType,
      season AS seasonId,
      str_to_date(SUBSTR(gameDate, 1, 10), '%Y-%m-%d') gameDate,
      isTie,
      gameNumber,
      doubleHeader,
      dayNight,
      scheduledInnings,
      gamesInSeries,
      seriesDescription,
      ifNecessaryDescription,
      gameId,
      abstractGameState,
      codedGameState,
      detailedState,
      awayWins,
      awayLosses,
      awayPct,
      awayScore,
      awayId AS awayTeamId,
      awayIsWinner,
      homeWins,
      homeLosses,
      homePct,
      homeScore,
      homeId AS homeTeamId,
      homeIsWinner,
      venueId,
      homeName homeTeamName,
      awayName awayTeamName,
      venueName,
      majorLeague,
      majorLeagueId,
      CASE
        WHEN gameType IN ('F', 'D', 'L', 'W') THEN 'PS'
        WHEN gameType = 'R' THEN 'RS'
        ELSE gameType
      END gameType2
    FROM s_game_context
  )
SELECT
  gamePk,
  gameType,
  seasonId,
  gameDate,
  isTie,
  gameNumber,
  doubleHeader,
  dayNight,
  scheduledInnings,
  gamesInSeries,
  seriesDescription,
  ifNecessaryDescription,
  gameId,
  abstractGameState,
  codedGameState,
  detailedState,
  awayWins,
  awayLosses,
  awayPct,
  awayScore,
  awayTeamId,
  awayIsWinner,
  homeWins,
  homeLosses,
  homePct,
  homeScore,
  homeTeamId,
  homeIsWinner,
  venueId,
  homeTeamName,
  awayTeamName,
  venueName,
  majorLeague,
  majorLeagueId,
  gameType2
FROM d
WHERE
  1 = 1
  AND gamePk NOT IN (
    SELECT
      gamePk
    FROM games
  );

COMMIT;

END //

Delimiter;
