

CREATE DATABASE online_shopping;

CREATE TABLE users(u_id INT PRIMARY KEY, username VARCHAR(20) NOT NULL,
			 passwords VARCHAR(10) NOT NULL, fname VARCHAR(15) NOT NULL,
			 lname VARCHAR(15) NOT NULL, u_address VARCHAR(50), tel NUMERIC(10));

CREATE TABLE shopping_session(ss_id INT PRIMARY KEY, 
			 u_id INT FOREIGN KEY REFERENCES users(u_id),
			 ss_total DECIMAL(8,2));

CREATE TABLE discount(d_id INT PRIMARY KEY, d_name VARCHAR(20) UNIQUE,
			 d_desc TEXT, discount_percent DECIMAL(4,2));

CREATE TABLE product(p_id INT PRIMARY KEY, p_name VARCHAR(50) NOT NULL,
			 p_desc TEXT, SKU VARCHAR(20) NOT NULL, category VARCHAR(20) UNIQUE, 
			 price MONEY NOT NULL, d_id INT FOREIGN KEY REFERENCES discount(d_id));



CREATE TABLE cart_item(ci_id INT PRIMARY KEY, 
			 ss_id INT FOREIGN KEY REFERENCES shopping_session(ss_id),
			 p_id INT FOREIGN KEY REFERENCES product(p_id),
			 quantity INT);

CREATE TABLE order_item(oi_id INT PRIMARY KEY,
			 p_id INT FOREIGN KEY REFERENCES product(p_id));

CREATE TABLE payment_details(pd_id INT PRIMARY KEY, 
			 oi_id INT FOREIGN KEY REFERENCES order_item(oi_id),
			 amount MONEY, provider_name VARCHAR(30),
			 status_pd VARCHAR(20), mode VARCHAR(20));

CREATE TABLE order_details(od_id INT PRIMARY KEY,
			 u_id INT FOREIGN KEY REFERENCES users(u_id),
			 od_total DECIMAL(7,2),
			 pd_id INT FOREIGN KEY REFERENCES payment_details(pd_id));


INSERT INTO users VALUES(1, 'kirti345', 'kirti@123', 'Kirti', 'Shetty', 'Mumbai', '8080160279'),
(2, 'sudip123', 'Sudip345@', 'Sudip', 'Patra', 'Kolkata', '7718910229'),
(3, 'rush25', 'rushk25', 'Rushda', 'Khan', 'UK', '8693000815'),
(4, 'sk291', 'sk2311', 'Srajan', 'Kotian', 'USA', '7738820617'),
(5, 'chiraag294', 'chirag@29', 'Chirag', 'Sharma', 'London', '9004889308');
SELECT * FROM users;


INSERT INTO shopping_session VALUES(1,1,107899.00), (2,2,5997.00), (3,3,15999.00), 
(4,4,1440.00), (5,5,1150.00);
SELECT* FROM shopping_session;


INSERT INTO discount VALUES(1, 'Big Billion Days','Users get 40% off on all mobile phones.' ,40),
(2, 'Summer Sale', 'Users get 50% off on Perfumes', 50),
(3, 'Diwali Dhamaka Sale','Users get 35% off on Laptops.', 35),
(4, 'Christmas Sale','Users get 30% off on all Electric Appliances.', 30),
(5, 'Rakshabandhan Sale', 'Users get 10% off on all Rakhi.', 10);
SELECT * FROM discount;


INSERT INTO product VALUES(1,'Yardley Perfume', '100 ml premium and long lasting perfume for women.', 'XYZ12345', 'Womens Perfume',649, 2)
INSERT INTO product VALUES(2, 'Denver Perfume', '60 ml premium and long lasting perfume for Men.', 'ABC34567', 'Mens Perfume', 575, 2 )
INSERT INTO product VALUES(3, 'Pigeon Electric Kettle', '22Lx15.7Wx24.5H. Rust-free interior with concealed heating elements.', 'DEF67890', 'Electric Kettle', 3200, 4)
INSERT INTO product VALUES(4, 'Galaxy M34 5G', '16.5 inch super-display with triple camera and android 13.0 OS', 'GHI23670', 'Mobile Phones', 25999, 1)
INSERT INTO product VALUES(5, 'Samsung Galaxy Tab S9 ', '27.81 cm (11 inch) Dynamic AMOLED 2X Display, RAM 12 GB, ROM 256 GB Expandable, S Pen in-Box, Wi-Fi Tablet, Beige.', 'LMN12569', 'Tablet', 93999, 4)
INSERT INTO product VALUES(6, 'Tyaani Jewellery', 'Gold-plated jewellery with anti-tarnish properties.', 'JKL31750', 'Accesories', 1999, NULL)
INSERT INTO product VALUES(7, 'beatXP Vega', '1.43" (3.6 cm) Super AMOLED Display, One-Tap Bluetooth Calling Smart Watch, 1000 Nits Brightness, Fast Charging, 24 * 7 Health Monitoring (Electric Black)', 'KSP68129', 'Smart Watch', 10999, 4)
INSERT INTO product VALUES(8, 'Amul Taaza Homeogenized toned Milk', '2 packs of 1 Litre containing milk in pasteurized state.', 'YZX56021', 'Groceries', 144, NULL )
INSERT INTO product VALUES(9, 'HP Victus Gaming Laptop', 'HP Victus Gaming Laptop AMD Ryzen 7 5800H,15.6 inch(39.6cm) FHD Gaming Laptop,16GB RAM,512GB SSD,NVIDIA® GeForce RTX™ 3050 4GB GDDR6 Graphics,Backlit KB,B&O(Win 11/Alexa/MSO', 'SRS71305', 'Gaming Laptop', 96705, 3)
INSERT INTO product VALUES(10,'HP [SmartChoice] 15s', 'Ryzen 5-5500U, 16GB RAM/512GB SSD 15.6"(39.6 cm) FHD, Micro-Edge, Anti-Glare Laptop/Alexa Built-in/Windows 11 /AMD Radeon Graphics/Dual Speakers/MSO 2021/1.69 Kg', 'YRF45086', 'Laptops', 82999, 3 );
SELECT * FROM product;

INSERT INTO cart_item VALUES(1,1,10,2), (2,3,4,1), (3,4,8,10), (4, 2,6,3), (5,5,2,4);
SELECT * FROM cart_item;

INSERT INTO order_item VALUES(1, 2), (2, 8), (3, 10), (4, 4), (5, 6);
SELECT * FROM order_item;

INSERT INTO payment_details VALUES(1, 2, 1440, 'Radheshyam Retailer', 'Pending', 'COD'), (2, 4, 15599, 'Darshit Electronics', 'Successful', 'UPI' ),
(3, 1, 1150, 'Bella Vita', 'Successful', 'Netbanking'), (4, 5, 5997, 'Tyani Jewellers', 'Pending', 'COD'), (5, 3, 107899, 'Sakshi Electronics', 'Failed', 'NetBanking');
SELECT * FROM payment_details;

INSERT INTO order_details VALUES (1,4, 1440, 1), (2,3, 15999, 2), (3, 5, 1150, 3), (4, 2, 5997, 4);
SELECT * FROM order_details;


SELECT p_id,p_name FROM product p WHERE p.p_id IN (SELECT o.p_id FROM order_item o);