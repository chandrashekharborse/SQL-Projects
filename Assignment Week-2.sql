use moviedb;

# 01 Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role
select a.act_fname,a.act_lname,amcm.role from actors a inner join 
(select mc.act_id,m.mov_id,mc.role from movie_cast mc inner join movie m on mc.mov_id = m.mov_id where mov_title ='Annie Hall' )
amcm on a.act_id =amcm.act_id group by a.act_fname,a.act_lname;

# 02 write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. 
# Return director first name, last name and movie title.
select d.dir_fname,d.dir_lname,mdmcm.mov_title from director d inner join (select md.dir_id,md.mov_id,mcm.mov_title from movie_direction md inner join 
(select m.mov_id,mc.role,m.mov_title from movie m inner join movie_cast mc on m.mov_id = mc.mov_id where mov_title = 'Eyes Wide Shut')
as mcm on md.mov_id = mcm.mov_id)as mdmcm on d.dir_id = mdmcm.dir_id group by d.dir_fname,d.dir_lname ;

# 03 Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title
select d.dir_fname,d.dir_lname,mdmcm.mov_title from director d inner join (select md.mov_id,md.dir_id,mcm.mov_title from movie_direction md inner join
(select mc.mov_id,m.mov_title,mc.act_id from  movie_cast mc inner join movie m  on m.mov_id = mc.mov_id where mc.role ='Sean Maguire') 
mcm on mcm.mov_id = md.mov_id) mdmcm on mdmcm.dir_id = d.dir_id group by d.dir_fname,d.dir_lname ;

# 04 Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.)
#Return actor first name, last name, movie title and release year
select a.act_fname,a.act_lname,mcm.mov_title,mcm.mov_dt_rel from actors a inner join
(select mc.mov_id,m.mov_title,m.mov_dt_rel,mc.act_id from movie m inner join movie_cast mc 
on m.mov_id = mc.mov_id where mov_year not between 1990 and 2000) mcm on mcm.act_id = a.act_id group by a.act_fname,a.act_lname;

# 05 Write a SQL query to find the directors with the number of genres of movies. 
#Group the result set on director first name, last name and generic title.
# Sort the result-set in ascending order by director first name and last name.
# Return director first name, last name and number of genres of movies.
select d.dir_fname,d.dir_lname,mgmmd.gen_title,count(mgmmd.gen_id) as no_of_genres_of_movies from director d inner join (select md.dir_id,mgm.gen_title,mgm.gen_id from movie_direction md inner join 
(select g.gen_title,mg.gen_id,mg.mov_id from genres g inner join movie_genres mg on mg.gen_id = g.gen_id) mgm on mgm.mov_id =md.mov_id) 
mgmmd on mgmmd.dir_id = d.dir_id group by d.dir_fname,d.dir_lname order by d.dir_fname,d.dir_lname asc;


