Insert Into cse532.facility
Select FacilityID,FacilityName,Description,Address1,Address2,City,State,ZipCode,CountyCode,County, DB2GSE.ST_POINT(Longitude, Latitude, 1)
From cse532.facilityoriginal;
