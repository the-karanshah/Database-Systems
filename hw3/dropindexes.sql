drop index cse532.facilityidx;
drop index cse532.zipidx;
drop index cse532.zipcodex;
drop index cse532.ZCTA5CE10x;
runstats on table cse532.uszip and indexes all;

runstats on table cse532.facility and indexes all;