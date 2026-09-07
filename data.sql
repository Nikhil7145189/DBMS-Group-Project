
-- NETFLIX DATABASE MANAGEMENT SYSTEM


-- Create Database
CREATE DATABASE NetflixDB;
USE NetflixDB;



CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);



CREATE TABLE SubscriptionPlans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration_months INT NOT NULL,
    max_devices INT NOT NULL
);



CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    plan_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (plan_id) REFERENCES SubscriptionPlans(plan_id)
);


-- INSERT DATA


INSERT INTO Users (name, email, password, phone)
VALUES
('Rahul Sharma', 'rahul@gmail.com', 'rahul123', '9876543210'),
('Aman Singh', 'aman@gmail.com', 'aman123', '9876543211'),
('Priya Verma', 'priya@gmail.com', 'priya123', '9876543212'),
('Rohan Gupta', 'rohan@gmail.com', 'rohan123', '9876543213');



INSERT INTO SubscriptionPlans
(plan_name, price, duration_months, max_devices)
VALUES
('Mobile', 149, 1, 1),
('Basic', 199, 1, 1),
('Standard', 499, 1, 2),
('Premium', 649, 1, 4);




INSERT INTO Subscriptions
(user_id, plan_id, start_date, end_date, status)
VALUES
(1, 4, '2026-09-01', '2026-10-01', 'Active'),
(2, 2, '2026-09-05', '2026-10-05', 'Active'),
(3, 3, '2026-08-15', '2026-09-15', 'Active'),
(4, 1, '2026-09-02', '2026-10-02', 'Active');



-- DISPLAY DATA


SELECT * FROM Users;

SELECT * FROM SubscriptionPlans;

SELECT * FROM Subscriptions;

