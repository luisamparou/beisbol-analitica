USE baseball;

DROP PROCEDURE rem_run_expectancy_matrix;

DELIMITER //

CREATE PROCEDURE rem_run_expectancy_matrix()
BEGIN

INSERT INTO rem_run_expectancy_matrix(
    majorLeagueId,
    seasonId,
    runnersBeforePlay,
    zeroOut,
    oneOut,
    twoOut,
    sortingOrder
  )
WITH run_expectancy_matrix AS (
  SELECT
    majorLeagueId,
    seasonId,
    outsBeforePlay,
    runnersBeforePlay,
    AVG(runsScoredEndInning - runsScoredBeforePlay) runExpectancy
  FROM rem_play_by_play
  WHERE
    (majorLeagueId, seasonId) NOT IN (
      SELECT
        majorLeagueId,
        seasonId
      FROM rem_run_expectancy_matrix
    )
  GROUP BY
    1, 2, 3, 4
)
SELECT
  majorLeagueId,
  seasonId,
  runnersBeforePlay,
  SUM(IF(outsBeforePlay = 0, runExpectancy, 0)) zeroOut,
  SUM(IF(outsBeforePlay = 1, runExpectancy, 0)) oneOut,
  SUM(IF(outsBeforePlay = 2, runExpectancy, 0)) twoOut,
  CASE
    WHEN runnersBeforePlay = '---' THEN 0
    WHEN runnersBeforePlay = '1--' THEN 1
    WHEN runnersBeforePlay = '-2-' THEN 2
    WHEN runnersBeforePlay = '12-' THEN 3
    WHEN runnersBeforePlay = '--3' THEN 4
    WHEN runnersBeforePlay = '1-3' THEN 5
    WHEN runnersBeforePlay = '-23' THEN 6
    WHEN runnersBeforePlay = '123' THEN 7
  END sortingOrder
FROM run_expectancy_matrix
GROUP BY
  1, 2, 3;

COMMIT;

END //

DELIMITER ;
