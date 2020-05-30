select year(transaction_date) || 
case 
when (cast (month(transaction_date) as int) < 10)
then '0' || cast(month(transaction_date) as int)
else cast (month(transaction_date) as char(2))
end as yeardate,
decimal(sum(dosage_unit),31,2) as monthly_counts,
decimal(avg(sum(dosage_unit)) 
	over (order by year(transaction_date), month(transaction_date) rows between 1 preceding and 1 following ),31,2) as smooth_counts
from cse532.dea_ny
group by year(transaction_date), month(transaction_date)