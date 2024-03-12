-- 𝐍𝐡𝐮̛̃𝐧𝐠 𝐬𝐚̉𝐧 𝐩𝐡𝐚̂̉𝐦 𝐧𝐚̀𝐨 𝐜𝐡𝐮́𝐧𝐠 𝐭𝐚 𝐧𝐞̂𝐧 đ𝐚̣̆𝐭 𝐡𝐚̀𝐧𝐠 𝐧𝐡𝐢𝐞̂̀𝐮 𝐡𝐨̛𝐧 𝐡𝐨𝐚̣̆𝐜 𝐢́𝐭 𝐡𝐨̛𝐧? 
select a.productName, a.productcode,
Round(Sum(b.quantityOrdered)*1.0/a.quantityInStock,2) as low_stock
from products as a 
join orderdetails as b on a.productCode= b.productCode
group by a.productName, a.productCode
order by low_stock DESC
limit 10;

select a.productName, a.productcode,
SUM(quantityOrdered * priceEach) AS prod_perf
from products as a 
join orderdetails as b on a.productCode= b.productCode
group by a.productName, a.productCode
order by prod_perf DESC
limit 10
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
/* 𝐂𝐡𝐮́𝐧𝐠 𝐭𝐚 𝐜𝐨́ 𝐭𝐡𝐞̂̉ 𝐜𝐡𝐢 𝐛𝐚𝐨 𝐧𝐡𝐢𝐞̂𝐮 đ𝐞̂̉ 𝐜𝐨́ đ𝐮̛𝐨̛̣𝐜 𝐤𝐡𝐚́𝐜𝐡 𝐡𝐚̀𝐧𝐠 𝐦𝐨̛́𝐢? 
Tìm số lượng khách hàng mới đến mỗi tháng. =>   kiểm tra xem liệu việc chi tiền để thu hút khách hàng mới có đáng hay không? 
Tính Giá trị trọn đời của khách hàng (LTV-Lifetime Value), đại diện cho số tiền trung bình mà khách hàng tạo ra. 
LTV cho chúng ta biết mức lợi nhuận trung bình mà một khách hàng tạo ra trong suốt thời gian họ sử dụng cửa hàng của chúng ta. 
Với LTV như vậy cửa hàng sẵn sàng bỏ ra bao nhiêu tiền để có được 1 khách hàng?, 
từ đó ước tính được trong tháng sau của hàng mong muốn có được 100 khách hàng mới thì sẽ cần bỏ ra bao nhiêu tiền. 
Chúng ta có thể quyết định dựa trên dự đoán số tiền chúng tôi có thể chi để thu hút khách hàng mới từ số LTV.
Giá trị mua hàng trung bình * Số lần mua hàng trung bình = Giá trị trung bình của khách hàng. 
Giá trị trung bình của khách hàng * Trung bình số năm mua hàng = Giá trị trọn đời khách hàng (CLV)
*/
with profit_by_customers as (
select a.customerNumber as customerNumber,
Sum(b.quantityOrdered * (b.priceEach- c.buyPrice))  as profit
from orders as a
join orderdetails as b on a.orderNumber=b.orderNumber
join products as c on b.productCode=c.productCode
group by a.customerNumber
order by Sum(b.priceEach- c.buyPrice) DESC )

select avg(profit) as LTV
from  profit_by_customers







