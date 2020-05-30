SELECT 
cse532.facility.facilityname,
DB2GSE.ST_ASTEXT(cse532.facility.geolocation),
cast(DB2GSE.ST_Distance(cse532.facility.geolocation, DB2GSE.ST_POINT(-72.993983, 40.824369, 1), 'STATUTE MILE') AS DECIMAL(10, 4)) as distance
FROM
cse532.facility
JOIN 
cse532.facilitycertification
ON cse532.facilitycertification.facilityid = cse532.facility.facilityid
WHERE 
cse532.facilitycertification.attributevalue = 'Emergency Department'
AND
DB2GSE.ST_Contains(DB2GSE.ST_Buffer(DB2GSE.ST_POINT(-72.993983, 40.824369, 1), 10, 'STATUTE MILE'), cse532.facility.geolocation) = 1
ORDER BY distance
LIMIT 1
;