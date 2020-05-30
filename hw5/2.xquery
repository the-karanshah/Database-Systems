 for 
 $id 
 in 
 distinct-values(doc("purchaseorders.xml")//PurchaseOrder/item/partid)
 let $items_price := doc("purchaseorders.xml")//item[partid = $id]
 order by $id
 return 
 <totalcost partid="{$id}" > 
 {
 format-number(sum($items_price/quantity) * distinct-values($items_price/price)
 , ".00")   
 } </totalcost>	