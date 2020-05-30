drop index cse532.facilityidx;
drop index cse532.zipidx;

create index cse532.facilityidx on cse532.facility(geolocation) extend using db2gse.spatial_index(0.85, 2, 5);

create index cse532.zipidx on cse532.uszip(shape) extend using db2gse.spatial_index(0.85, 2, 5);

--added following
drop index cse532.zipcodex;
drop index cse532.facilityidx2;
drop index cse532.ZCTA5CE10x;
create index cse532.zipcodex on cse532.facility(zipcode);
create index cse532.ZCTA5CE10x on cse532.uszip(ZCTA5CE10);

runstats on table cse532.uszip and indexes all;



runstats on table cse532.facility and indexes all;