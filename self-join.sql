/* 
Final section of sqlzoon, SELF JOIN
*/ 

--#1
/*
How many stops are in the database.
*/
SELECT COUNT(*)
FROM stops

--#2
/*
Find the id value for the stop 'Craiglockhart'
*/
SELECT id 
FROM stops
WHERE name = 'Craiglockhart'

--#3
/*
Give the id and the name for the stops on the '4' 'LRT' service.
*/
SELECT id, name
FROM stops
JOIN route ON id = stop
WHERE company = 'LRT' AND num = '4'

--#4
/*
The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause 
to restrict the output to these two routes.
*/
SELECT company, num, COUNT(*) AS visits
FROM route 
WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING visits = 2

--#5
/*
Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, 
without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
*/
SELECT r1.company, r1.num, r1.stop, r2.stop
FROM route AS r1
JOIN route AS r2 ON (r1.company = r2.company) AND (r1.num = r2.num)
WHERE r1.stop = 53
AND r2.stop = 149

--#6
/*
The query shown is similar to the previous one, however by joining two copies of the stops table we can refer 
to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' 
are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
*/
SELECT r1.company, r1.num, s1.name, s2.name
FROM route r1
JOIN route r2 ON(r1.company = r2.company AND r1.num=r2.num)
JOIN stops s1 ON (r1.stop=s1.id)
JOIN stops s2 ON (r2.stop=s2.id)
WHERE s1.name='Craiglockhart' AND s2.name = 'London Road'

--#7
/*
Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
*/
SELECT DISTINCT(r1.company), r2.num
FROM route AS r1
JOIN route AS r2 ON(r1.company = r2.company AND r1.num = r2.num)
WHERE r1.stop = 115 AND r2.stop = 137

--#8
/*
Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
*/
SELECT r1.company, r1.num
FROM route AS r1
JOIN route AS r2 ON(r1.company = r2.company AND r1.num = r2.num)
JOIN stops AS s1 ON(r1.stop = s1.id)
JOIN stops AS s2 ON(r2.stop = s2.id)
WHERE s1.name = 'Craiglockhart' AND s2.name = 'Tollcross'

--#9
/*
Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' 
itself, offered by the LRT company. Include the company and bus no. of the relevant services.
*/
SELECT DISTINCT(s2.name, r1.company, r1.num) 
FROM route AS r1 
JOIN route AS r2 ON (r1.company = r2.company AND r1.num = r2.num
JOIN stops AS s1 ON (r1.stop = s1.id)
JOIN stops AS s2 ON (r2.stop = s2.id)
WHERE s1.name = 'Craiglockhart'

--#10
/*
Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.
*/
SELECT r1.num, r1.company, s2.name, r3.num, r3.company 
FROM route AS r1 
JOIN route AS r2 ON (r1.company = r2.company AND r1.num = r2.num)
JOIN route AS r3 ON (r2.stop = r3.stop)
JOIN route AS r4 ON (r3.company = r4.company AND r3.num = r4.num)
JOIN stops AS s1 ON (r1.stop = s1.id)
JOIN stops AS s2 ON (r2.stop = s2.id)
JOIN stops AS s3 ON (r3.stop = s3.id)
JOIN stops AS s4 ON (r4.stop = s4.id)
WHERE s1.name = 'Craiglockhart' AND s4.name = 'Lochend' AND s2.id = s3.id

