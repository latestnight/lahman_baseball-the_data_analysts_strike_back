/*7.  From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 116
What is the smallest number of wins for a team that did win the world series? 63
Doing this will probably result in an unusually small number of wins for a world series champion 
– determine why this is the case. Then redo your query, excluding the problem year. 1981
How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
-- -- What percentage of the time?*/

SELECT yearID, teamID, W, L, WSWIN
FROM teams
WHERE yearID >= 1970;

--Part 2
-- SELECT DISTINCT seriespost.yearID, round, teams.teamID, teams.W
-- FROM seriespost INNER JOIN teams ON seriespost.yearID = teams.yearID AND seriespost.teamIDwinner = teams.teamID
-- WHERE round = 'WS' and seriespost.yearID >= 1970
-- ORDER BY teams.W 
--Part 1
-- SELECT yearID, teamID, W, WSWin
-- FROM teams
-- WHERE yearID >= 1970 AND WSWIN LIKE 'N'
-- ORDER BY W DESC
--Part 3
-- SELECT DISTINCT seriespost.yearID, round, teams.teamID, teams.W
-- FROM seriespost INNER JOIN teams ON seriespost.yearID = teams.yearID AND seriespost.teamIDwinner = teams.teamID
-- WHERE round = 'WS' and seriespost.yearID >= 1970 AND NOT (seriespost.yearID = 1981)
-- ORDER BY teams.W DESC


