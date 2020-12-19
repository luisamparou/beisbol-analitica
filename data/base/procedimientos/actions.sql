USE baseball;

DROP PROCEDURE actions;

DELIMITER //

CREATE PROCEDURE actions()
BEGIN

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
FROM stg_play_action
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


-- Probablemente esto este mal. Utilizar runners.
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

DELIMITER ;
