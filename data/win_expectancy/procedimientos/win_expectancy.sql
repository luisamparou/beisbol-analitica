USE baseball;

DROP PROCEDURE we_win_expectancy;

DELIMITER //

CREATE PROCEDURE we_win_expectancy()
BEGIN

INSERT INTO we_win_expectancy(
    majorLeagueId,
    seasonId,
    runnersBeforePlay,
    outsBeforePlay,
    battingTeamScore,
    win_expectancy
  )
  WITH pbp AS (
    SELECT
      majorLeagueId,
      seasonId,
      runnersBeforePlay,
      outsBeforePlay,
      CASE
        WHEN battingteamscore - pitchingteamscore <= -5 THEN -5
        WHEN battingteamscore - pitchingteamscore >= 5 THEN 5
        ELSE battingteamscore - pitchingteamscore
      END battingTeamScore,
      IF(battingteamscoreendgame > pitchingteamscoreendgame, 'W', 'L') result,
      COUNT(1) n
    FROM rem_play_by_play
    WHERE
      (
        scheduledInnings > inning
        OR (
          scheduledInnings = inning
          AND halfInning = 'top'
        )
      )
    GROUP BY
      1, 2, 3, 4, 5, 6
  ),
  w AS (
    SELECT
      majorLeagueId,
      seasonId,
      runnersBeforePlay,
      outsBeforePlay,
      battingTeamScore,
      result,
      n w
    FROM pbp
    WHERE
      result = 'W'
  ),
  l AS (
    SELECT
      majorLeagueId,
      seasonId,
      runnersBeforePlay,
      outsBeforePlay,
      battingTeamScore,
      result,
      n l
    FROM pbp
    WHERE
      result = 'L'
  )
SELECT
  w.majorLeagueId,
  w.seasonId,
  w.runnersBeforePlay,
  w.outsBeforePlay,
  w.battingTeamScore,
  IF(w.battingTeamScore = 0, 0.50, w / (l + w)) win_expectancy
FROM w
INNER JOIN l
  ON w.majorLeagueId = l.majorLeagueId
  AND w.seasonId = l.seasonId
  AND w.runnersBeforePlay = l.runnersBeforePlay
  AND w.outsBeforePlay = l.outsBeforePlay
  AND w.battingTeamScore = l.battingTeamScore;

END //

DELIMITER ;
