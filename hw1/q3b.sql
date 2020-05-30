with buyerCTE (buyer_zip, totalmme)
as (select buyer_zip,
		   sum(mme) as totalmme
    from cse532.dea_ny
    group by buyer_zip)
select buyer_zip as ZipCodes,
	   totalmme / z.zpop as MME_Normalised,
	   rank() over(order by totalmme / z.zpop desc) as Rank
from buyerCTE
inner join
cse532.zippop as z
on buyer_zip = z.zip
where
z.zpop is not null
and
z.zpop > 0
limit 5