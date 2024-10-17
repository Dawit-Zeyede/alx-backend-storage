-- Creates a stored procedure ComputeAverageWeightedScoreForUsers that
-- computes and stores the average weighted score for all students.
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers ()
BEGIN
    -- Create a temporary table to hold weighted scores and weights
    CREATE TEMPORARY TABLE TempUserScores (
        user_id INT NOT NULL,
        total_weighted_score INT NOT NULL DEFAULT 0,
        total_weight INT NOT NULL DEFAULT 0
    );

    -- Insert total weighted scores and total weights into the temporary table
    INSERT INTO TempUserScores (user_id, total_weighted_score, total_weight)
        SELECT c.user_id,
               SUM(c.score * p.weight) AS total_weighted_score,
               SUM(p.weight) AS total_weight
        FROM corrections c
        INNER JOIN projects p
            ON c.project_id = p.id
        GROUP BY c.user_id;

    -- Update the users table by calculating the average score using the temporary table
    UPDATE users u
    INNER JOIN TempUserScores t
        ON u.id = t.user_id
    SET u.average_score = IF(t.total_weight = 0, 0, t.total_weighted_score / t.total_weight);

    -- Drop the temporary table after use
    DROP TEMPORARY TABLE IF EXISTS TempUserScores;
END $$

DELIMITER ;
