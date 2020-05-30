1...................
a.
db2se enable_db cse532

b.
db2 -tf import_zip.sql

c.
db2 -tf createfacilititytable.sql

d.
db2 load from "C:\Users\Karan\Desktop\StonyBrook\sem2\ToDB\assignments\3\Health_Facility_General_Information.csv" of del MESSAGES load.msg INSERT INTO cse532.facilityoriginal

e.
db2 -tf facilityinsert.sql

f.
db2 -tf createfacilititycertificationtable.sql
db2 load from "C:\Users\Karan\Desktop\StonyBrook\sem2\ToDB\assignments\3\Health_Facility_Certification_Information.csv" of del MESSAGES load.msg INSERT INTO cse532.facilitycertification

g.
db2 -tf createindexes.sql

2...................
db2 -tf nearester.sql
answer -> Long Island Community Hospital  3.2460

3...................
db2 -tf noerzips.sql
answer -> 208 records

4...................
db2 -tf nearester.sql
with index  ->   0.246 seconds
db2 -tf dropindexes.sql
db2 -tf nearester.sql
without index -> 0.299 seconds

db2 -tf createindexes.sql
db2 -tf noerzips.sql
with index  ->   3.408 seconds
db2 -tf dropindexes.sql
db2 -tf noerzips.sql
without index -> 3.641 seconds

5...................
db2 -tf mergezip.sql
logic: Creating two tables: 1st(named primarytable) for regions having higher populations than avaerage,
and 2nd(named temptable) for lesser populations than avaerage
iterating through temptable table, find a single neighbor, merge (combine shape), check population,
if higher population than average add that new shape into primarytable table else in temptable table
after adding entry of combined, remove the two entries from respective tables
same way iterate through temptable table till it gets empty
primarytable table will be the final answer having combined/non-combined regions with population greater than the average