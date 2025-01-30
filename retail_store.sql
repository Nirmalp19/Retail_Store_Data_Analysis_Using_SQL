select count(*) from retail_store.customer;
select count(*) from retail_store.prod_cat_info;
select count(*) from retail_store.transactions;


select count(Qty) from retail_store.transactions
where Qty like "-%";

select prod_cat from retail_store.prod_cat_info
where prod_subcat = "DIY";

select store_type,count(store_type) from retail_store.transactions 
group by store_type;

select Gender, count(Gender) from retail_store.customer
where Gender in ('M','F')
group by Gender ;

select city_code , count(city_code) from retail_store.customer
group by city_code
order by city_code desc
limit 1;

select distinct(count(prod_subcat)) from retail_store.prod_cat_info
where prod_cat = "Books";

select cust_id, sum(Qty) as sum from retail_store.transactions 
group by cust_id
order by sum desc;

select  sum(t.total_amt) as sum from retail_store.transactions as t inner join retail_store.prod_cat_info as p on t.prod_cat_code = p.prod_cat_code and t.prod_subcat_code = p.prod_sub_cat_code
where prod_cat in ("Books","Electronics");

select count(customer_id) as CountofCustomer from retail_store.customer
where customer_Id in (select cust_id from retail_store.transactions left join retail_store.customer on customer_id = cust_id 
where total_amt not like '-%'
group by cust_id
having count(transaction_id)>10)

select sum(t.total_amt) as sum from retail_store.transactions as t inner join retail_store.prod_cat_info as p on t.prod_cat_code = p.prod_cat_code and t.prod_subcat_code = p.prod_sub_cat_code
where prod_cat in ("Books","Clothing") and Store_type = "Flagship store" ;

select  prod_subcat, sum(total_amt) as sum from retail_store.customer as c inner join retail_store.transactions as t on c.customer_Id = t.cust_id
inner join retail_store.prod_cat_info as pci on t.prod_cat_code = pci.prod_cat_code
and t.prod_subcat_code = pci.prod_sub_cat_code
where Gender = "M" and prod_cat = "Electronics"
group by prod_subcat;


select prod_subcat,(sum(total_amt)/(select sum(total_amt)from retail_store.transactions))*100 as SalesPercentage,
(count(case when Qty < 0 then Qty else null end)/sum(Qty))*100 as Percentageofreturn
from retail_store.transactions as t inner join retail_store.prod_cat_info as pci on t.prod_cat_code = pci.prod_cat_code and t.prod_subcat_code = pci.prod_sub_cat_code
group by prod_subcat
order by sum(total_amt) desc
limit 5;

select cust_id , sum(total_amt) from retail_store.transactions
group by cust_id;

 select pci.prod_cat,sum(total_amt) as sum from retail_store.transactions as t inner join retail_store.prod_cat_info as pci on t.prod_cat_code = pci.prod_cat_code and t.prod_subcat_code = pci.prod_sub_cat_code
 where total_amt < 0
 group by prod_cat
 order by sum desc;
 

 
 select Store_type,sum(total_amt) as TotalSales, sum(Qty) as TotalQuantity from retail_store.transactions
 group by Store_type
 having sum(total_amt) >=All  (select sum(total_amt) from retail_store.transactions group by Store_type) and 
 sum(qty) >=all (select sum(qty) from retail_store.transactions group by Store_type)

 
select prod_cat,prod_subcat, avg(total_amt) as AverageRevenue,sum(total_amt)as TotalRevenue from  retail_store.Transactions as t
inner join retail_store.prod_cat_info as p
on p.prod_cat_code =t.prod_cat_code and prod_sub_cat_code =prod_subcat_code
where prod_cat in (select prod_cat from  retail_store.Transactions as t inner join retail_store.prod_cat_info as p on
t.prod_cat_code=p.prod_cat_code and p.prod_sub_cat_code = t.prod_subcat_code
group by prod_cat
order by sum(Qty) desc)
group by p.prod_cat,p.prod_subcat
limit 5;
 
 

