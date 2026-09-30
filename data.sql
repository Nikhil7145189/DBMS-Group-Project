
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


CREATE TABLE Profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    profile_name VARCHAR(50) NOT NULL,
    age_limit INT DEFAULT 18,

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    release_year YEAR,
    duration_minutes INT,
    language VARCHAR(50),
    country VARCHAR(50)
);


CREATE TABLE TVShows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    release_year YEAR,
    language VARCHAR(50),
    country VARCHAR(50)
);



CREATE TABLE Episodes (
    episode_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT,
    season_number INT NOT NULL,
    episode_number INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    duration_minutes INT,

    FOREIGN KEY (show_id) REFERENCES TVShows(show_id)
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

INSERT INTO Profiles
(user_id, profile_name, age_limit)
VALUES
(1, 'Rahul', 18),
(1, 'Kids', 12),
(2, 'Aman', 18),
(3, 'Priya', 18),
(4, 'Rohan', 18);


INSERT INTO Movies
(title, description, release_year, duration_minutes, language, country)
VALUES
('Inception',
 'A thief enters peoples dreams.',
 2010, 148, 'English', 'USA'),

('3 Idiots',
 'Three engineering students experience college life.',
 2009, 170, 'Hindi', 'India'),

('Interstellar',
 'A journey through space and time.',
 2014, 169, 'English', 'USA'),

('Dangal',
 'A father trains his daughters to become wrestlers.',
 2016, 161, 'Hindi', 'India'),

('The Dark Knight',
 'Batman faces a dangerous criminal mastermind.',
 2008, 152, 'English', 'USA');


INSERT INTO TVShows
(title, description, release_year, language, country)
VALUES
('Stranger Things',
 'A group of friends face supernatural events.',
 2016, 'English', 'USA'),

('Money Heist',
 'A group attempts a major robbery.',
 2017, 'Spanish', 'Spain'),

('Wednesday',
 'A student investigates mysterious events.',
 2022, 'English', 'USA');



INSERT INTO Episodes
(show_id, season_number, episode_number, title, duration_minutes)
VALUES
(1, 1, 1, 'The Vanishing of Will Byers', 50),
(1, 1, 2, 'The Weirdo on Maple Street', 56),
(1, 1, 3, 'Holly Jolly', 51),

(2, 1, 1, 'Episode 1', 48),
(2, 1, 2, 'Episode 2', 42),

(3, 1, 1, 'Wednesday Child Is Full of Woe', 50),
(3, 1, 2, 'Woe What a Night', 48);


-- DISPLAY DATA


SELECT * FROM Users;

SELECT * FROM SubscriptionPlans;

SELECT * FROM Subscriptions;

SELECT * FROM Profiles;

SELECT * FROM Movies;

SELECT * FROM TVShows;

SELECT * FROM Episodes;

