--Q3:Male Employees with Net Salary >= 8000, Ordered by Seniority --
SELECT 
    E.EMPLOYEE_NUMBER,
    E.First_Name,
    E.Last_Name,
    DATEDIFF(YEAR, E.BIRTH_DATE, GETDATE()) AS Age,
    DATEDIFF(YEAR, E.HIRE_DATE, GETDATE()) AS Seniority
FROM EMPLOYEES E
WHERE E.TITLE ='Mr.'
AND (E.SALARY + ISNULL(E.COMMISSION, 0)) >= 8000
ORDER BY Seniority DESC;
/*Q4: Display products that meet the following criteria: (C1) quantity is packaged in bottle(s), (C2) the third character in the product name is 't' or 'T', (C3) supplied by suppliers 1, 2, or 3, (C4) unit price ranges between 70 and 200, and (C5) units ordered are specified (not null) */
SELECT product_name , product_ref, quantity,supplier_number,units_on_order, unit_price
FROM PRODUCTS
WHERE quantity like '%bottles%'
and (SUBSTRING(PRODUCT_NAME,3,1)='t' or SUBSTRING(PRODUCT_NAME,3,1)='T')
and SUPPLIER_NUMBER in (1,2,3)
and UNIT_PRICE > 70 and UNIT_PRICE < 200
and units_on_order is not null
/*Q5:Customers in the Same Region as Supplier 1 */
SELECT * 
FROM CUSTOMERS C
WHERE C.COUNTRY = (SELECT COUNTRY FROM SUPPLIERS WHERE SUPPLIER_NUMBER = 1)
  AND C.CITY = (SELECT CITY FROM SUPPLIERS WHERE SUPPLIER_NUMBER = 1)
  AND RIGHT(C.POSTAL_CODE, 3) = RIGHT((SELECT POSTAL_CODE FROM SUPPLIERS WHERE SUPPLIER_NUMBER = 1), 3);
  
/* Q6:For each order number between 10998 and 11003, do the following:  
-Display the new discount rate, which should be 0% if the total order amount before discount (unit price * quantity) is between 0 and 2000, 5% if between 2001 and 10000, 10% if between 10001 and 40000, 15% if between 40001 and 80000, and 20% otherwise.
-Display the message "apply old discount rate" if the order number is between 10000 and 10999, and "apply new discount rate" otherwise. The resulting table should display the columns: order number, new discount rate, and discount rate application note. */
SELECT 
    ORDER_NUMBER,
    UNIT_PRICE * QUANTITY AS TotalAmountBeforeDiscount,
    CASE 
        WHEN UNIT_PRICE * QUANTITY BETWEEN 0 AND 2000 THEN '0%'
        WHEN UNIT_PRICE * QUANTITY BETWEEN 2001 AND 10000 THEN '5%'
        WHEN UNIT_PRICE * QUANTITY BETWEEN 10001 AND 40000 THEN '10%'
        WHEN UNIT_PRICE * QUANTITY BETWEEN 40001 AND 80000 THEN '15%'
        ELSE '20%'
    END AS Discount,
	    CASE 
        WHEN ORDER_NUMBER BETWEEN 10000 AND 10999 THEN 'apply old discount rate'
        ELSE 'apply new discount rate'
    END AS DiscountRateApplicationNote
FROM ORDER_DETAILS
WHERE ORDER_NUMBER BETWEEN 10998 AND 11003;
--Q7:Display suppliers of beverage products. The resulting table should display the columns: supplier number, company, address, and phone number.
--
SELECT s.SUPPLIER_NUMBER, s.COMPANY, s.ADDRESS, s.PHONE
FROM SUPPLIERS s
JOIN PRODUCTS p ON s.SUPPLIER_NUMBER = p.SUPPLIER_NUMBER
JOIN CATEGORIES c ON p.CATEGORY_CODE = c.CATEGORY_CODE
WHERE c.CATEGORY_NAME = 'Beverages';
--Q8:Display customers from Berlin who have ordered at most 1 (0 or 1) dessert product. The resulting table should display the column: customer code.--
SELECT c.CUSTOMER_CODE
FROM CUSTOMERS c
JOIN ORDERS o ON c.CUSTOMER_CODE = o.CUSTOMER_CODE
JOIN ORDER_DETAILS od ON o.ORDER_NUMBER = od.ORDER_NUMBER
JOIN PRODUCTS p ON od.PRODUCT_REF = p.PRODUCT_REF
JOIN CATEGORIES cat ON p.CATEGORY_CODE = cat.CATEGORY_CODE
WHERE c.CITY = 'Berlin' 
and cat.CATEGORY_NAME='dessert'
GROUP BY c.CUSTOMER_CODE 
HAVING count(od.PRODUCT_REF)<=1
--Q9:Display customers who reside in France and the total amount of orders they placed every Monday in April 1998 (considering customers who haven't placed any orders yet). The resulting table should display the columns: customer number, company name, phone number, total amount, and country.
--
SELECT 
    c.CUSTOMER_CODE, 
    c.COMPANY, 
    c.PHONE, 
    c.COUNTRY
FROM 
    CUSTOMERS c
LEFT JOIN 
    ORDERS o ON c.CUSTOMER_CODE = o.CUSTOMER_CODE
LEFT JOIN 
    ORDER_DETAILS od ON o.ORDER_NUMBER = od.ORDER_NUMBER
WHERE 
    c.COUNTRY = 'France' 
    AND (O.ORDER_DATE IS NULL OR (YEAR(O.ORDER_DATE) = 1998 
       AND MONTH(O.ORDER_DATE) = 4 
       AND DATENAME(WEEKDAY, O.ORDER_DATE) = 'Monday'))
GROUP BY 
    c.CUSTOMER_CODE, c.COMPANY, c.PHONE, c.COUNTRY
ORDER BY 
    c.CUSTOMER_CODE;
--Q10:Display customers who have ordered all products. The resulting table should display the columns: customer code, company name, and telephone number.
SELECT c.CUSTOMER_CODE,c.COMPANY,c.PHONE
FROM CUSTOMERS c
JOIN ORDERS o ON c.CUSTOMER_CODE=o.CUSTOMER_CODE
JOIN ORDER_DETAILS od ON o.ORDER_NUMBER = od.ORDER_NUMBER
JOIN PRODUCTS p ON od.PRODUCT_REF = p.PRODUCT_REF
GROUP BY c.CUSTOMER_CODE, c.COMPANY, c.PHONE
HAVING COUNT(DISTINCT p.PRODUCT_REF) = (SELECT COUNT(*) FROM PRODUCTS);
--Q11: Display for each customer from France the number of orders they have placed. The resulting table should display the columns: customer code and number of orders.
--
SELECT c.CUSTOMER_CODE,COUNT(o.ORDER_NUMBER) AS NUMBER_OF_ORDERS
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CUSTOMER_CODE = o.CUSTOMER_CODE
WHERE c.COUNTRY = 'France'
GROUP BY c.CUSTOMER_CODE
ORDER BY c.CUSTOMER_CODE;
--Q12:Display the number of orders placed in 1996, the number of orders placed in 1997, and the difference between these two numbers. The resulting table should display the columns: orders in 1996, orders in 1997, and Difference.
--
SELECT 
    (SELECT COUNT(*) FROM orders WHERE YEAR(order_date) = 1996) AS orders_in_1996,
    (SELECT COUNT(*) FROM orders WHERE YEAR(order_date) = 1997) AS orders_in_1997,
    ((SELECT COUNT(*) FROM orders WHERE YEAR(order_date) = 1997) - 
     (SELECT COUNT(*) FROM orders WHERE YEAR(order_date) = 1996)) AS Difference;
