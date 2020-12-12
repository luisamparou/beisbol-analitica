USE baseball;

DROP PROCEDURE master_procedure();

DELIMITER //

CREATE PROCEDURE master_procedure()
BEGIN

CALL batting_orders();
CALL games();
CALL players();
CALL game_player_batting_stats();
CALL game_player_fielding_stats();
CALL game_player_pitching_stats();
CALL game_batting_orders();
CALL teams();
CALL game_player_positions();
CALL atbats();
CALL pitches();
CALL runners();
CALL fielding_credits();
CALL actions();
CALL pickoffs();
CALL clean_staging_tables();

END //

DELIMITER;
