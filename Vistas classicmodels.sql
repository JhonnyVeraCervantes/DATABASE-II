create view productos_mas_vendidos as 
SELECT products.productName as nombreProducto, productlines.productLine as lineaProducto, SUM(orderdetails.priceEach - products.buyPrice) as utilidadProducto, SUM(quantityOrdered * priceEach) as ventaTotal
FROM products, productlines, orderdetails
WHERE products.productCode = orderdetails.productCode AND products.productLine = productlines.productLine
GROUP BY products.productCode
ORDER BY SUM(quantityOrdered) DESC
LIMIT 1;

select*from productos_mas_vendidos;
 

create definer = root@`%` view mejor_cliente_compras as
select `classicmodels`.`customers`.`customerName` AS                   `nombreCliente`,
       sum((`classicmodels`.`orderdetails`.`quantityOrdered` *
            `classicmodels`.`orderdetails`.`priceEach`)) AS            `ventaTotalCliente`,
       count(distinct `classicmodels`.`orderdetails`.`productCode`) AS `productosDiferentes`,
       min(`classicmodels`.`orders`.`orderDate`) AS                    `fechaInicio`,
       max(`classicmodels`.`orders`.`orderDate`) AS                    `fechaFin`
from `classicmodels`.`customers`
         join `classicmodels`.`orderdetails`
         join `classicmodels`.`orders`
where ((`classicmodels`.`customers`.`customerNumber` = `classicmodels`.`orders`.`customerNumber`) and
       (`classicmodels`.`orders`.`orderNumber` = `classicmodels`.`orderdetails`.`orderNumber`))
group by `classicmodels`.`customers`.`customerName`
order by `productosDiferentes` desc, `fechaInicio`, `fechaFin`;


DELIMITER //
CREATE PROCEDURE MejorCliente (fechaInicio DATE, fechaFin DATE)
BEGIN
    START TRANSACTION;
            SELECT * FROM mejor_cliente_compras
            WHERE fechaInicio = mejor_cliente_compras.fechaInicio AND fechaFin = mejor_cliente_compras.fechaFin;
END //
DELIMITER ;

CALL MejorCliente ('2003-07-07', '2005-04-01');



use classicmodels;

DELIMITER //
CREATE PROCEDURE OrdenarProducto (orderNumber int, orderDate date, requiredDate date, shippedDate date, status varchar(15), comments text, customerNumber int, productCode varchar(15), quantityOrdered int, priceEachP decimal(10, 2), orderLineNumber smallint)
BEGIN
            insert  into `orders`(`orderNumber`,`orderDate`,`requiredDate`,`shippedDate`,`status`,`comments`,`customerNumber`)
            values (orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber);
            insert  into `orderdetails`(`orderNumber`,`productCode`,`quantityOrdered`,`priceEach`,`orderLineNumber`)
            values  (orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber);
END //
DELIMITER ;

