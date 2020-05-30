select 
DISTINCT((substr(cse532.facility.zipcode,1,5))) as ZipCodes
from 
cse532.facility 
where 
substr(cse532.facility.zipcode,1,5)  -- neighbors from facility not having emergency dept.
not in 
(
    select 
    s.ZCTA5CE10 
    from
    (
        select *
        from cse532.uszip
        inner join
        (
            select 
            DISTINCT(substr(cse532.facility.zipcode,1,5)) as zipcode
            from
            cse532.facility
            inner join 
            (
                select 
                * 
                from cse532.facilitycertification 
                where
                cse532.facilitycertification.attributevalue = 'Emergency Department'
            ) as step1   -- from certification, ids with emergency dept.
            on
            cse532.facility.facilityid = step1.facilityid
        ) as step2   -- zipcodes having emergency dept.
        on 
        cse532.uszip.ZCTA5CE10 = step2.zipcode
    ) as step3,  -- zipcodes from uszips having emergency dept.
    cse532.uszip as s
    where
    db2gse.ST_Intersects(step3.shape, s.shape) = 1  -- neighbors from uszips having emergency dept.
) 
and 
substr(cse532.facility.zipcode,1,5)  -- zipcodes from facility not having emergency dept.
not in
(
    select 
    DISTINCT(substr(cse532.facility.zipcode,1,5)) as zipcode
    from 
    (
        select 
        facilityid 
        from 
        cse532.facilitycertification
        where
        cse532.facilitycertification.attributevalue = 'Emergency Department'
    ) as step1
    inner join 
    cse532.facility 
    on 
    cse532.facility.facilityID = step1.facilityId 
)
and
substr(cse532.facility.zipcode,1,5)  -- zipcodes having records in uszips
in
(
    select 
    ZCTA5CE10 as zipcode
    from 
    cse532.uszip
)
;
