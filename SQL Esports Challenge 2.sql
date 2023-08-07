#1. What are the names of the players whose salary is greater than 100,000?

Select player_name,salary from players
where salary > 100000

#2. What is the team name of the player with player_id = 3?

Select t.team_name,p.player_name,t.team_id
from players p
join teams t on p.team_id=t.team_id
where p.player_id=3


#3. What is the total number of players in each team?

Select t.team_name,count(t.team_id) as no_of_players
from players p
join teams t on p.team_id=t.team_id
group by t.team_name

#4. What is the team name and captain name of the team with team_id = 2?

Select t.team_name,p.player_name as captain_name
from teams t
join players p on t.team_id=p.team_id and t.captain_id=player_id
where t.team_id=2

#5. What are the player names and their roles in the team with team_id = 1?

Select p.player_name,p.role
from players p
join teams t on p.team_id=t.team_id 
where t.team_id=1

#6. What are the team names and the number of matches they have won?

Select t.team_name,count(m.winner_id) as winner_count
from teams t
join matches m on t.team_id=m.winner_id
group by t.team_name
order by count(m.winner_id) desc

#7. What is the average salary of players in the teams with country 'USA'?

Select t.team_name,Round(Avg(p.salary)) as Avg_salary
from players p
join teams t on p.team_id=t.team_id
where country ='USA'
group by t.team_name

#8. Which team won the most matches?

Select t.team_name,count(m.winner_id) as won_most_matches
from matches m
join teams t on m.winner_id=t.team_id
group by t.team_name
order by count(m.winner_id) desc 
limit 1


#9. What are the team names and the number of players in each team whose salary is greater than 100,000?

Select t.team_name,count(p.player_id) as player_count
from teams t
join players p on t.team_id=p.team_id
where p.salary > 100000
group by t.team_name
order by player_count desc

#10. What is the date and the score of the match with match_id = 3?

Select match_id,match_date,score_team1,score_team2 
from matches
where match_id=3
