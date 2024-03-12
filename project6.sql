-- 𝐍𝐡𝐮̛̃𝐧𝐠 𝐬𝐚̉𝐧 𝐩𝐡𝐚̂̉𝐦 𝐧𝐚̀𝐨 𝐜𝐡𝐮́𝐧𝐠 𝐭𝐚 𝐧𝐞̂𝐧 đ𝐚̣̆𝐭 𝐡𝐚̀𝐧𝐠 𝐧𝐡𝐢𝐞̂̀𝐮 𝐡𝐨̛𝐧 𝐡𝐨𝐚̣̆𝐜 𝐢́𝐭 𝐡𝐨̛𝐧? 
select a.productName,
min(a.quantityInStock), max(b.quantityOrdered)
from products as a 
join orderdetails as b on a.productCode= b.productCode;

select a.productName,
max(a.quantityInStock), min(b.quantityOrdered)
from products as a 
join orderdetails as b on a.productCode= b.productCode
/* 𝐂𝐡𝐮́𝐧𝐠 𝐭𝐚 𝐧𝐞̂𝐧 đ𝐢𝐞̂̀𝐮 𝐜𝐡𝐢̉𝐧𝐡 𝐜𝐚́𝐜 𝐜𝐡𝐢𝐞̂́𝐧 𝐥𝐮̛𝐨̛̣𝐜 𝐭𝐢𝐞̂́𝐩 𝐭𝐡𝐢̣ 𝐯𝐚̀ 𝐭𝐫𝐮𝐲𝐞̂̀𝐧 𝐭𝐡𝐨̂𝐧𝐠 𝐧𝐡𝐮̛ 𝐭𝐡𝐞̂́ 𝐧𝐚̀𝐨 𝐜𝐡𝐨 𝐩𝐡𝐮̀ 𝐡𝐨̛̣𝐩 𝐯𝐨̛́𝐢 𝐡𝐚̀𝐧𝐡 𝐯𝐢 𝐜𝐮̉𝐚 𝐤𝐡𝐚́𝐜𝐡 𝐡𝐚̀𝐧𝐠? 
  ⇒ Đ𝐢𝐞̂̀𝐮 𝐧𝐚̀𝐲 𝐥𝐢𝐞̂𝐧 𝐪𝐮𝐚𝐧 đ𝐞̂́𝐧 𝐯𝐢𝐞̣̂𝐜 𝐩𝐡𝐚̂𝐧 𝐥𝐨𝐚̣𝐢 𝐤𝐡𝐚́𝐜𝐡 𝐡𝐚̀𝐧𝐠: Tìm khách hàng VIP (khách hàng có tần suất mua hàng cao, giá trị đơn hàng lớn) và 
  nhóm khách hàng ít tương tác (khách hàng đã ngừng sử dụng sản phẩm/ dịch vụ hoặc tần suất mua hàng thấp.
       Lợi nhuận = Tổng doanh thu - Giá vốn bán hàng = P*Q - PQ1
  buyPrice: giá vốn trên một sản phẩm.
  priceEach: giá bán trên một sản phẩm*/
with profit_by_customers as (
select a.customerNumber as customerNumber,
Sum(b.quantityOrdered * (b.priceEach- c.buyPrice))  as profit
from orders as a
join orderdetails as b on a.orderNumber=b.orderNumber
join products as c on b.productCode=c.productCode
group by a.customerNumber
order by Sum(b.priceEach- c.buyPrice) DESC )

select cus.customerNumber, cus.contactLastName, cus.contactFirstName,
cus.city, cus.country,
cte.profit
from profit_by_customers as cte
join customers as cus on cte.customerNumber = cus.customerNumber
limit 5
-- 𝐂𝐡𝐮́𝐧𝐠 𝐭𝐚 𝐜𝐨́ 𝐭𝐡𝐞̂̉ 𝐜𝐡𝐢 𝐛𝐚𝐨 𝐧𝐡𝐢𝐞̂𝐮 đ𝐞̂̉ 𝐜𝐨́ đ𝐮̛𝐨̛̣𝐜 𝐤𝐡𝐚́𝐜𝐡 𝐡𝐚̀𝐧𝐠 𝐦𝐨̛́𝐢? */








