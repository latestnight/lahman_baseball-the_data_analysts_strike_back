-- What range of years for baseball games played does the provided database cover?
-- Answer: 1871-2016
SELECT MIN(year) AS starting_year,
       MAX(year) AS ending_year
FROM homegames;

-- Find the name and height of the shortest player in the database.
-- How many games did he play in? What is the name of the team for which he played?
-- Answer: Edward Carl (43 inches), 1 game, St.Louis Browns
select namefirst || ' ' || namelast as full_name,
       height,
       a.teamid,
       t.name,
       a.G_all,
       p.playerid
from people as p
join appearances as a using(playerid)
join teams as t using(teamid)
group by full_name, height, a.teamid, t.name, a.G_all, p.playerid
order by height
limit 1;

-- Find all players in the database who played at Vanderbilt University.
-- Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues.
-- Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
-- Answer: David Price
-- Answer: $81,851,296
select distinct namefirst || ' ' || namelast as full_name,
                cp.playerid,
                schoolid,
                sum(salary) as total_salary
from collegeplaying as cp
join people as p using(playerid)
join salaries as s using(playerid)
where schoolid = 'vandy'
group by cp, full_name, playerid, schoolid
-- you can apparently group by (collapse) whole tables
-- who knew?
order by total_salary desc;

-- Using the fielding table, group players into three groups based on their position:
-- label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery".
-- Determine the number of putouts made by each of these three groups in 2016.
-- Answer:  Battery - 41424
-- Answer:  Infield - 58934
-- Answer: Outfield - 29560
select sum(po) as total_putouts,
       case 
            when pos = 'OF' then 'Outfield'
            when pos = '1B' or pos = '2B' or pos = 'SS' or pos = '3B' then 'Infield'
            else 'Battery'
       end as position_group
from fielding
where yearid = '2016'
group by position_group;

-- Find the average number of strikeouts per game by decade since 1920.
-- Round the numbers you report to 2 decimal places. Do the same for home runs per game.
-- Do you see any trends?
-- Answer: Each decade k/g and hr/g increase, even as the number of games has increased with extra teams
WITH decades AS (
                     select yearid,
                            g,
                            so,
                            hr,
                            case
                                 when yearid between 1920 and 1929 then '1920s'
                                 when yearid between 1930 and 1939 then '1930s'
                                 when yearid between 1940 and 1949 then '1940s'
                                 when yearid between 1950 and 1959 then '1950s'
                                 when yearid between 1960 and 1969 then '1960s'
                                 when yearid between 1970 and 1979 then '1970s'
                                 when yearid between 1980 and 1989 then '1980s'
                                 when yearid between 1990 and 1999 then '1990s'
                                 when yearid between 2000 and 2009 then '2000s'
                                 when yearid between 2010 and 2019 then '2010s'
                            end as decade
                      from teams
                      where yearid >= 1920
                 )
select decade,
       sum(so) as total_k,
       sum(g) as total_g,
       sum(hr) as total_hr,
       round(sum(so::numeric)/sum(g), 2) as k_per_g,
       round(sum(hr::numeric)/sum(g), 2) as hr_per_g
from decades
group by decade
order by decade;

-- Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful.
-- (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases.
-- Answer: Chris Owings
-- Answer: 91.3% success rate
with sb_attempts as (
                     select playerid, 
                            yearid,
                            sb,
                            cs,
                            round((sb::numeric/(sb+cs))*100, 2) || '%' as sb_percentage
                     from batting
                     where sb+cs >= 20
                     and yearid = 2016
                    )
select namefirst||' '||namelast as full_name,
       yearid,
       sb,
       cs,
       sb_percentage
from sb_attempts join people using(playerid)
order by sb_percentage desc;


-- From 1970 – 2016, what is the largest number of wins for a team that did not win the world series?
-- What is the smallest number of wins for a team that did win the world series?
-- Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case.
-- Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series?
-- What percentage of the time?

ronit

-- Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016
-- (where average attendance is defined as total attendance divided by number of games).
-- Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

kenny

-- Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)?
-- Give their full name and the teams that they were managing when they won the award.

me

-- Find all players who hit their career highest number of home runs in 2016.
-- Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016.
-- Report the players' first and last names and the number of home runs they hit in 2016.

jeremy

-- Is there any correlation between number of wins and team salary? Use data from 2000 and later to answer this question.
-- As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis.



-- Does there appear to be any correlation between attendance at home games and number of wins?



-- Do teams that win the world series see a boost in attendance the following year? What about teams that made the playoffs?
-- Making the playoffs means either being a division winner or a wild card winner.



-- It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective.
-- Investigate this claim and present evidence to either support or dispute this claim.
-- First, determine just how rare left-handed pitchers are compared with right-handed pitchers. 
-- Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make it into the hall of fame?