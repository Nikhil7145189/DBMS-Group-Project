-- ============================================
-- NETFLIX DATABASE MANAGEMENT SYSTEM
-- ============================================

-- Create Database
CREATE DATABASE NetflixDB;
USE NetflixDB;


-- ============================================
-- 1. USERS TABLE
-- ============================================

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);


-- ============================================
-- 2. SUBSCRIPTION PLANS TABLE
-- ============================================

CREATE TABLE SubscriptionPlans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration_months INT NOT NULL,
    max_devices INT NOT NULL
);


-- ============================================
-- 3. SUBSCRIPTIONS TABLE
-- ============================================

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


-- ============================================
-- 4. PROFILES TABLE
-- ============================================

CREATE TABLE Profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    profile_name VARCHAR(50) NOT NULL,
    age_limit INT DEFAULT 18,

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


-- ============================================
-- 5. MOVIES TABLE
-- ============================================

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    release_year YEAR,
    duration_minutes INT,
    language VARCHAR(50),
    country VARCHAR(50)
);


-- ============================================
-- 6. TV SHOWS TABLE
-- ============================================

CREATE TABLE TVShows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    release_year YEAR,
    language VARCHAR(50),
    country VARCHAR(50)
);


-- ============================================
-- 7. EPISODES TABLE
-- ============================================

CREATE TABLE Episodes (
    episode_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT,
    season_number INT NOT NULL,
    episode_number INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    duration_minutes INT,

    FOREIGN KEY (show_id) REFERENCES TVShows(show_id)
);


-- ============================================
-- 8. GENRES TABLE
-- ============================================

CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);


-- ============================================
-- 9. MOVIE GENRES TABLE
-- ============================================

CREATE TABLE MovieGenres (
    movie_id INT,
    genre_id INT,

    PRIMARY KEY (movie_id, genre_id),

    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);


-- ============================================
-- 10. TV SHOW GENRES TABLE
-- ============================================

CREATE TABLE ShowGenres (
    show_id INT,
    genre_id INT,

    PRIMARY KEY (show_id, genre_id),

    FOREIGN KEY (show_id) REFERENCES TVShows(show_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);


-- ============================================
-- 11. WATCH HISTORY TABLE
-- ============================================

CREATE TABLE WatchHistory (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    movie_id INT NULL,
    episode_id INT NULL,
    watched_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    progress_minutes INT DEFAULT 0,

    FOREIGN KEY (profile_id) REFERENCES Profiles(profile_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (episode_id) REFERENCES Episodes(episode_id)
);


-- ============================================
-- 12. RATINGS TABLE
-- ============================================

CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    movie_id INT NULL,
    show_id INT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),

    FOREIGN KEY (profile_id) REFERENCES Profiles(profile_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (show_id) REFERENCES TVShows(show_id)
);


-- ============================================
-- 13. WATCHLIST TABLE
-- ============================================

CREATE TABLE Watchlist (
    watchlist_id INT PRIMARY KEY AUTO_INCREMENT,
    profile_id INT,
    movie_id INT NULL,
    show_id INT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (profile_id) REFERENCES Profiles(profile_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (show_id) REFERENCES TVShows(show_id)
);


-- ============================================
-- INSERT DATA
-- ============================================


-- ============================================
-- USERS
-- ============================================

INSERT INTO Users (name, email, password, phone)
VALUES
('Rahul Sharma', 'rahul@gmail.com', 'rahul123', '9876543210'),
('Aman Singh', 'aman@gmail.com', 'aman123', '9876543211'),
('Priya Verma', 'priya@gmail.com', 'priya123', '9876543212'),
('Rohan Gupta', 'rohan@gmail.com', 'rohan123', '9876543213');


-- ============================================
-- SUBSCRIPTION PLANS
-- ============================================

INSERT INTO SubscriptionPlans
(plan_name, price, duration_months, max_devices)
VALUES
('Mobile', 149, 1, 1),
('Basic', 199, 1, 1),
('Standard', 499, 1, 2),
('Premium', 649, 1, 4);


-- ============================================
-- SUBSCRIPTIONS
-- ============================================

INSERT INTO Subscriptions
(user_id, plan_id, start_date, end_date, status)
VALUES
(1, 4, '2026-09-01', '2026-10-01', 'Active'),
(2, 2, '2026-09-05', '2026-10-05', 'Active'),
(3, 3, '2026-08-15', '2026-09-15', 'Active'),
(4, 1, '2026-09-02', '2026-10-02', 'Active');


-- ============================================
-- PROFILES
-- ============================================

INSERT INTO Profiles
(user_id, profile_name, age_limit)
VALUES
(1, 'Rahul', 18),
(1, 'Kids', 12),
(2, 'Aman', 18),
(3, 'Priya', 18),
(4, 'Rohan', 18);


-- ============================================
-- MOVIES
-- ============================================

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


-- ============================================
-- TV SHOWS
-- ============================================

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


-- ============================================
-- EPISODES
-- ============================================

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


-- ============================================
-- GENRES
-- ============================================

INSERT INTO Genres (genre_name)
VALUES
('Action'),
('Comedy'),
('Drama'),
('Sci-Fi'),
('Thriller'),
('Horror'),
('Romance');


-- ============================================
-- MOVIE GENRES
-- ============================================

INSERT INTO MovieGenres (movie_id, genre_id)
VALUES
(1, 4), -- Inception - Sci-Fi
(1, 5), -- Inception - Thriller

(2, 2), -- 3 Idiots - Comedy
(2, 3), -- 3 Idiots - Drama

(3, 4), -- Interstellar - Sci-Fi
(3, 3), -- Interstellar - Drama

(4, 3), -- Dangal - Drama
(4, 1), -- Dangal - Action

(5, 1), -- Dark Knight - Action
(5, 5); -- Dark Knight - Thriller


-- ============================================
-- SHOW GENRES
-- ============================================

INSERT INTO ShowGenres (show_id, genre_id)
VALUES
(1, 4), -- Stranger Things - Sci-Fi
(1, 6), -- Stranger Things - Horror
(1, 5), -- Stranger Things - Thriller

(2, 5), -- Money Heist - Thriller
(2, 3), -- Money Heist - Drama

(3, 6), -- Wednesday - Horror
(3, 5); -- Wednesday - Thriller


-- ============================================
-- WATCH HISTORY
-- ============================================

INSERT INTO WatchHistory
(profile_id, movie_id, episode_id, progress_minutes)
VALUES
(1, 1, NULL, 120),
(1, 3, NULL, 169),
(2, 2, NULL, 80),
(3, NULL, 1, 35),
(3, NULL, 2, 40),
(4, 5, NULL, 100),
(5, NULL, 6, 30);


-- ============================================
-- RATINGS
-- ============================================

INSERT INTO Ratings
(profile_id, movie_id, show_id, rating)
VALUES
(1, 1, NULL, 5),
(1, 3, NULL, 5),
(2, 2, NULL, 4),
(3, NULL, 1, 5),
(4, 5, NULL, 5),
(5, NULL, 3, 4);


-- ============================================
-- WATCHLIST
-- ============================================

INSERT INTO Watchlist
(profile_id, movie_id, show_id)
VALUES
(1, 4, NULL),
(1, NULL, 1),
(2, 2, NULL),
(3, 5, NULL),
(4, NULL, 2),
(5, NULL, 3);


-- ============================================
-- DISPLAY DATA
-- ============================================

SELECT * FROM Users;

SELECT * FROM SubscriptionPlans;

SELECT * FROM Subscriptions;

SELECT * FROM Profiles;

SELECT * FROM Movies;

SELECT * FROM TVShows;

SELECT * FROM Episodes;

SELECT * FROM Genres;

SELECT * FROM MovieGenres;

SELECT * FROM ShowGenres;

SELECT * FROM WatchHistory;

SELECT * FROM Ratings;

SELECT * FROM Watchlist;