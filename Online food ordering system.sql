
CREATE DATABASE FoodOrdering;
USE FoodOrdering;
CREATE TABLE Restaurants (restaurant_id INT PRIMARY KEY,restaurant_name VARCHAR(100),location VARCHAR(100),cuisine VARCHAR(50));

CREATE TABLE Menu(menu_id INT PRIMARY KEY,restaurant_id INT,item_name VARCHAR(100),price INT,availability VARCHAR(20),FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id));
CREATE TABLE Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(100),phone VARCHAR(15),city VARCHAR(50));

CREATE TABLE Orders (order_id INT PRIMARY KEY,customer_id INT,menu_id INT,quantity INT,order_date DATE,order_status VARCHAR(20),FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),FOREIGN KEY (menu_id) REFERENCES Menu(menu_id));

CREATE TABLE Payments (payment_id INT PRIMARY KEY,order_id INT,payment_method VARCHAR(20),amount INT,payment_status VARCHAR(20),payment_date DATE,FOREIGN KEY (order_id) REFERENCES Orders(order_id));
INSERT INTO Restaurants VALUES (101,'Spicy Kitchen', 'Hyderabad', 'Indian'),(102,'Pizza Hub', 'Bengaluru', 'Italian'),
(103,'Dragon Bowl', 'Chennai', 'Chinese'),(104,'Burger World', 'Vijayawada', 'Fast Food'),(105,'Ocean Grill', 'Visakhapatnam', 'Seafood');

INSERT INTO MENU VALUES(201,101,'Chicken Biryani',250,'Available'), (202,101,'Paneer Curry',180,'Available'),
(203,102,'Veg Pizza',350,'Available'), (204,102,'Cheese Pasta',280,'Available'),
(205,103,'Noodles',220,'Available'), (206,103,'Fried Rice',240,'Unavailable'), 
(207,104,'ChickenBurger',180,'Available'), (208,104,'French Fries',120,'Available'),
 (209,105,'GrilledFish',450,'Available'), (210,105,'Prawn Curry',500,'Available');

INSERT INTO CUSTOMERS VALUES(301,'Aarav','9876500001','Hyderabad'), (302,'Bhavya','9876500002','Vijayawada'),(303,'Charan','9876500003','Vizag'), (304,'Divya','9876500004','Bengaluru'),(305,'Esha','9876500005','Chennai'), (306,'Farhan','9876500006','Mumbai'),
(307,'Gopi','9876500007','Warangal'), (308,'Harini','9876500008','Guntur'),(309,'Ishaan','9876500009','Pune'), (310,'John','9876500010','Kochi');
INSERT INTO Orders VALUES(401,301,201,2,'2026-07-01','Delivered'), (402,302,203,1,'2026-07-02','Delivered'),(403,303,205,3,'2026-07-03','Preparing'), (404,304,207,2,'2026-07-04','Delivered'),(405,305,210,1,'2026-07-05','Cancelled'), (406,306,202,2,'2026-07-06','Delivered'),
(407,307,208,4,'2026-07-07','Delivered'), (408,308,209,1,'2026-07-08','Preparing'),(409,309,204,2,'2026-07-09','Delivered'), (410,310,201,1,'2026-07-10','Delivered'),(411,301,210,2,'2026-07-11','Preparing'), (412,303,203,1,'2026-07-12','Delivered');

INSERT INTO PAYMENTS VALUES(501,401,'UPI',500,'Paid','2026-07-01'),(502,402,'Card',350,'Paid','2026-07-02'),(503,403,'UPI',660,'Paid','2026-07-03'),(504,404,'Cash',360,'Paid','2026-07-04'),(505,405,'Card',500,'Refunded','2026-07-05'),
(506,406,'UPI',360,'Paid','2026-07-06'),(507,407,'Cash',480,'Paid','2026-07-07'),(508,408,'UPI',450,'Pending','2026-07-08'),(509,409,'Card',560,'Paid','2026-07-09'),
(510,410,'UPI',250,'Paid','2026-07-10'),(511,411,'Card',1000,'Pending','2026-07-11'),(512,412,'Cash',350,'Paid','2026-07-12');


select * from  Restaurants;
select * from MENU;
select * from   CUSTOMERS;
select * from Orders;
select * from PAYMENTS;


#1.Display all restaurants and their cuisine types.
SELECT restaurant_name, Cuisine FROM Restaurants;

#2.Update the order status from Preparing to Delivered.
UPDATE Orders SET order_status='Delivered' WHERE order_status = 'Preparing';
set sql_safe_updates=0;

#3.Increase the price of all food items in a specific restaurant by 10%.
UPDATE Menu SET price = price * 1.10 WHERE restaurant_id = 101;

#4.Delete a cancelled order
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM Orders WHERE order_status = 'Cancelled';
SET FOREIGN_KEY_CHECKS=1;


#5.Display all restaurant names in uppercase
SELECT UPPER(restaurant_name) AS Restaurant_Name FROM Restaurants;


#6.Display all menu item names in lowercase.
SELECT LOWER(item_name) AS item_name_lower FROM Menu;

#7.Display the first five characters of each menu item.
SELECT SUBSTRING(item_name, 1, 5) AS short_name FROM Menu;

#8.Concatenate the customer name and city.
SELECT CONCAT(customer_name, ' - ', city) AS customer_city FROM Customers;

#9.Replace the word Chicken with Grilled in product names.
SELECT REPLACE(item_name, 'Chicken', 'Grilled') AS new_item_name FROM Menu;

#10. Display last week orders.
SELECT * FROM Orders WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

#11.Display the day name for every order date.
SELECT order_id, DAYNAME(order_date) AS day_name FROM Orders;

#12. Find the number of days since each order was placed
SELECT order_id, DATEDIFF(CURDATE(), order_date) AS days_since_order FROM Orders;

#13.Display the payment date in DD-Monday-YYYY format.
SELECT payment_id, DATE_FORMAT(payment_date, '%d-%M-%Y') AS formatted_date FROM Payments;

#14. Display the month and year of each payment.
SELECT payment_id, MONTHNAME(payment_date) AS month, YEAR(payment_date) AS year FROM Payments;

#15.Count the total number of menu items available in each restaurant.
SELECT restaurant_id, COUNT(menu_id) AS total_items FROM Menu GROUP BY restaurant_id;

#16.display the average product of menu items for every restaurant.
SELECT restaurant_id, AVG(price) AS avg_price FROM Menu GROUP BY restaurant_id;

#17. Find the highest payment amount received.
SELECT MAX(amount) AS highest_payment FROM Payments;

#18.Display the total revenue generated by each restaurant.
SELECT R.restaurant_name, SUM(P.amount) AS total_revenue FROM Restaurants R JOIN Menu M ON R.restaurant_id = M.restaurant_id JOIN Orders O ON M.menu_id = O.menu_id
JOIN Payments P ON O.order_id = P.order_id GROUP BY R.restaurant_name;

#19.find the total quantity ordered for each menu item
select m.item_name,sum(o.quantity) as total_quantity from menu M join orders O on M.menu_id = O.menu_id group by m.item_name;


#20.Display customer names along with the food items they ordered.
SELECT C.customer_name, M.item_name FROM Customers C JOIN Orders O ON C.customer_id = O.customer_id JOIN Menu M ON O.menu_id = M.menu_id;

#21.Display restaurant names with their menu items.
SELECT R.restaurant_name, M.item_name FROM Restaurants R JOIN Menu M ON R.restaurant_id = M.restaurant_id;

#22.Display customer names, ordered food items, and order status. 
SELECT C.customer_name, M.item_name, O.order_status FROM Customers C JOIN Orders O ON C.customer_id = O.customer_id JOIN Menu M ON O.menu_id = M.menu_id;

#23. Display restaurant names, menu items, quantity ordered, and payment amount.
SELECT R.restaurant_name, M.item_name, O.quantity, P.amount FROM Restaurants R JOIN Menu M ON R.restaurant_id = M.restaurant_id JOIN Orders O ON M.menu_id = O.menu_id JOIN Payments P ON O.order_id = P.order_id;


#24.Display all restaurants and their menu items, even if no orders have been placed
SELECT R.restaurant_name, M.item_name FROM Restaurants R LEFT JOIN Menu M ON R.restaurant_id = M.restaurant_id LEFT JOIN Orders O ON M.menu_id = O.menu_id;

#25. Display customer names, restaurant names, ordered food items, and order dates in a single result.
SELECT C.customer_name, R.restaurant_name, M.item_name, O.order_date FROM Customers C JOIN Orders O ON C.customer_id = O.customer_id JOIN Menu M ON O.menu_id = M.menu_id JOIN Restaurants R ON M.restaurant_id = R.restaurant_id;

#26. Find customers whose payment amount is greater than the average payment amount.
SELECT C.customer_name, P.amount FROM Customers C JOIN Orders O ON C.customer_id = O.customer_id JOIN Payments P ON O.order_id = P.order_id WHERE P.amount > (SELECT AVG(amount) FROM Payments);

#27. Display the restaurant that serves the most expensive food item.
SELECT R.restaurant_name, M.item_name, M.price FROM Restaurants R JOIN Menu M ON R.restaurant_id = M.restaurant_id WHERE M.price = (SELECT MAX(price) FROM  Menu);


#28.Find customers who ordered the highest-priced menu item.
SELECT C.customer_name, M.item_name, M.price FROM Customers C JOIN Orders O ON C.customer_id = O.customer_id JOIN Menu M ON O.menu_id = M.menu_id
WHERE M.price = (SELECT MAX(price) FROM menu);

#29.display restaurants that have never received an order
select R.restaurant_name from restaurants R where r.restaurant_id not in (select distinct m.restaurant_id from menu  M join orders o ON M.menu_id=O.menu_id);


#30.create a view  named customer_order_ history displaying customer_name ,resturant_name,menu_item ,quantity,order status

create view customer_order_history  as select  c.customer_name,R.restaurant_name,m.item_name,o.quantity,order_status from customers c join orders o on c.customer_id = o.customer_id join menu m on o.menu_id = m.menu_id join restaurants r on m.restaurant_id = r.restaurant_id;


#31.create view named restaurant_revenue displaying restaurant name,total orders,total revenue
CREATE VIEW Restaurant_Revenue AS SELECT R.restaurant_name, COUNT(O.order_id) AS total_orders, SUM(P.amount) AS total_revenue FROM Restaurants R JOIN Menu M ON R.restaurant_id=M.restaurant_id 
JOIN Orders O ON M.menu_id=O.menu_id JOIN Payments P ON O.order_id=P.order_id GROUP BY R.restaurant_name;

#32.reterive records from both views
SELECT * FROM Customer_Order_History;
SELECT * FROM Restaurant_Revenue;


#33. Transaction with SAVEPOINT
START TRANSACTION;
UPDATE Menu SET price = 550 WHERE menu_id = 1;
SAVEPOINT price_update;
UPDATE Payments SET payment_status = 'Completed' WHERE payment_id = 1;
ROLLBACK TO SAVEPOINT price_update;
COMMIT;


# 34. Stored procedure to display all orders by customer_id
DELIMITER // CREATE PROCEDURE GetOrdersByCustomer(IN cust_id INT)
BEGIN
SELECT o.order_id, m.item_name, o.quantity, o.order_date, o.order_status FROM Orders o JOIN Menu m ON o.menu_id=m.menu_id WHERE o.customer_id=cust_id;
END //
DELIMITER ;
 CALL GetOrdersByCustomer(301);

# 35. Procedure to calculate total amount spent by customer
DELIMITER //
CREATE PROCEDURE TotalSpentByCustomer(IN cust_id INT)
BEGIN
SELECT SUM(p.amount) AS total_spent FROM Orders o JOIN Payments p ON o.order_id=p.order_id WHERE o.customer_id=cust_id AND p.payment_status='Paid';
END //
DELIMITER ;

# 36. Trigger on delete -> archive
CREATE TABLE Orders_Archive LIKE Orders;
DELIMITER //
CREATE TRIGGER after_order_delete AFTER DELETE ON Orders FOR EACH ROW
BEGIN
INSERT INTO Orders_Archive VALUES (OLD.order_id, OLD.customer_id, OLD.menu_id, OLD.quantity, OLD.order_date, OLD.order_status);
END //
DELIMITER ;

#37. Trigger on status change -> history
CREATE TABLE Order_Status_History (history_id INT AUTO_INCREMENT PRIMARY KEY, order_id INT, old_status VARCHAR(20), new_status VARCHAR(20), change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
DELIMITER //
CREATE TRIGGER track_status_change BEFORE UPDATE ON Orders FOR EACH ROW
BEGIN
IF OLD.order_status != NEW.order_status THEN
INSERT INTO Order_Status_History(order_id, old_status, new_status) VALUES (OLD.order_id, OLD.order_status, NEW.order_status);
END IF;
END //
DELIMITER ;







