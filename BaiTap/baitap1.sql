use demo;
create table Products(
Id int primary key,
productCode int not null,
productName varchar(30),
productPrice float default 0,
productAmount int check(productAmount>=0) default 0,
productDescription varchar(50),
productStatus bit
);
create unique index proCode on products(productCode);
ALTER TABLE Products ADD INDEX name_price(productName,productPrice);
create view showproduct as 
select productCode, productName, productPrice, productStatus
from Products;
-- sua view
alter view showproduct as
select productDescription
from Products;
-- delete view
drop view showproduct;
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter &&
create procedure getdatproduct()
begin 
select *from Products;
end &&
delimiter &&;
-- insert product.
delimiter &&
create procedure insertproduct(in Id int ,in productCode int ,in productName varchar(30),in productPrice float ,in productAmount int ,in productDescription varchar(50),in productStatus bit)
begin 
insert into Products 
values (id,productCode,productName,productPrice,productAmount,productDescription,productStatus);
end &&
delimiter &&
-- Tạo store procedure sửa thông tin sản phẩm theo id 
delimiter &&
create procedure editbyId(in pId int ,in pCode int ,in pName varchar(30),in pPrice float ,in pAmount int ,in pDescription varchar(50),in pStatus bit)
begin 
update Products 
set productCode = pCode ,productName = pName,productPrice= pPrice,productAmount =pAmount,productDescription = pDescription,productStatus= pStatus
where Id=pid;
end &&
delimiter &&;
--  Tạo store procedure xoá sản phẩm theo id 
delimiter &&
create procedure deleteproduct(in pId int)
begin 
delete from Products
where id=pId;
end &&
delimiter &&;
