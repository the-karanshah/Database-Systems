-- 33121 records
-- 9111 is avg
--logic: Creating two tables: 1st(named primarytable) for regions having higher populations than avaerage,
-- and 2nd(named temptable) for lesser populations than avaerage
-- iterating through temptable table, find a single neighbor, merge (combine shape), check population,
-- if higher population than average add that new shape into primarytable table else in temptable table
-- after adding entry of combined, remove the two entries from respective tables
-- same way iterate through temptable table till it gets empty
-- primarytable table will be the final answer having combined/non-combined regions with population greater than the average

select 
avg(zpop)
from 
cse532.zippop 
where 
zip 
in 
(
    select 
    DISTINCT(ZIP)
    from 
    cse532.zippop
); -- find avg

select 
shape, zpop 
into 
#primarytable
from cse532.zippop
inner join
cse532.uszip
on
cse532.zippop.zipcode = cse532.uszip.ZCTA5CE10
where 
zip 
in
(
    select 
    DISTINCT(ZIP)
    from 
    cse532.zippop
)
AND
pop > 9111; -- create primary table

select 
shape, zpop 
into 
#temptable
from cse532.zippop
inner join
cse532.uszip
on
cse532.zippop.zipcode = cse532.uszip.ZCTA5CE10
where 
zip 
in
(
    select 
    DISTINCT(ZIP)
    from 
    cse532.zippop
)
AND
pop <= 9111; -- create temp table

WHILE (Select Count(*) From #temptable) > 0
BEGIN
    if exists (
        select 
        shape, zpop
        from
        temptable
        where
        db2gse.ST_Intersects(shape, primarytable.shape) = 1
    )
        if sum(zpop, primarytable.zpop) > 9111
            UPDATE 
            primarytable 
            set 
            shape = ST_Intersection(shape, primarytable.shape) -- merge in primarytable
        ELSE
            UPDATE 
            temptable 
            set 
            shape = ST_Intersection(shape, primarytable.shape) -- merge in temptable
END;
	
DROP TABLE ##temptable;
-- primarytable is the final answer