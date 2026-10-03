# Netflix Database Management System

A MySQL-based database project that models the core data operations of a Netflix-style streaming platform. It is designed for DBMS coursework and demonstrates relational schema design, table relationships, sample data, SQL queries, relational algebra, and normalization.

> **Project scope:** This is a database-layer academic model. It does not implement video streaming, a web interface, payment processing, authentication, or Netflix's actual internal systems.

## Table of Contents

- [Overview](#overview)
- [Objectives](#objectives)
- [Features](#features)
- [Technology](#technology)
- [Database Schema](#database-schema)
- [Entity Relationships](#entity-relationships)
- [Normalization](#normalization)
- [Getting Started](#getting-started)
- [Sample Data](#sample-data)
- [Example SQL Queries](#example-sql-queries)
- [Relational Algebra](#relational-algebra)
- [Constraints and Design Notes](#constraints-and-design-notes)
- [Possible Enhancements](#possible-enhancements)
- [Project Structure](#project-structure)
- [Disclaimer](#disclaimer)

## Overview

The database represents a streaming service where an account can have multiple profiles and a subscription plan. The content catalog contains movies and TV shows. TV shows are organized into episodes, while movies and shows can be assigned multiple genres. Profiles can maintain watch history, rate content, and save content to a watchlist.

The schema separates entities and many-to-many relationships into dedicated tables to reduce repeated data and make common queries easier to express.

## Objectives

- Design a relational database for a streaming-platform use case.
- Identify entities, attributes, primary keys, and foreign keys.
- Represent one-to-many and many-to-many relationships.
- Apply normalization principles up to Third Normal Form (3NF).
- Practice SQL DDL, DML, joins, filtering, aggregation, and relational algebra.
- Provide sample records for testing and demonstration.

## Features

- **Account management:** Store user account details.
- **Multiple profiles:** Associate several viewing profiles with one user.
- **Subscription plans:** Define plans, prices, durations, and device limits.
- **Subscription records:** Track a user's plan and subscription period.
- **Content catalog:** Store movie and TV-show metadata.
- **Episodes and seasons:** Associate episodes with TV shows.
- **Genre classification:** Assign multiple genres to movies and shows.
- **Watch history:** Record viewing activity and progress by profile.
- **Ratings:** Store profile ratings for movies or TV shows.
- **Watchlists:** Let profiles save movies and shows for later.
- **Query practice:** Support joins, selection, projection, and other common DBMS operations.

## Technology

- **Database:** MySQL 8.0 or compatible version
- **Query language:** SQL
- **Suggested client:** MySQL Workbench or the MySQL command-line client

## Database Schema

The database is named `NetflixDB` and contains 13 tables.

| Table | Purpose | Primary key |
|---|---|---|
| `Users` | Account information | `user_id` |
| `SubscriptionPlans` | Available subscription plans | `plan_id` |
| `Subscriptions` | User subscription periods and status | `subscription_id` |
| `Profiles` | Profiles under an account | `profile_id` |
| `Movies` | Movie catalog | `movie_id` |
| `TVShows` | TV-show catalog | `show_id` |
| `Episodes` | Episodes belonging to TV shows | `episode_id` |
| `Genres` | Genre names | `genre_id` |
| `MovieGenres` | Movie-to-genre mapping | (`movie_id`, `genre_id`) |
| `ShowGenres` | TV-show-to-genre mapping | (`show_id`, `genre_id`) |
| `WatchHistory` | Viewing history and progress | `history_id` |
| `Ratings` | Profile ratings for movies or shows | `rating_id` |
| `Watchlist` | Saved movies or shows per profile | `watchlist_id` |

### Main attributes

- **Users:** `user_id`, `name`, `email`, `password`, `phone`
- **SubscriptionPlans:** `plan_id`, `plan_name`, `price`, `duration_months`, `max_devices`
- **Subscriptions:** `subscription_id`, `user_id`, `plan_id`, `start_date`, `end_date`, `status`
- **Profiles:** `profile_id`, `user_id`, `profile_name`, `age_limit`
- **Movies:** `movie_id`, `title`, `description`, `release_year`, `duration_minutes`, `language`, `country`
- **TVShows:** `show_id`, `title`, `description`, `release_year`, `language`, `country`
- **Episodes:** `episode_id`, `show_id`, `season_number`, `episode_number`, `title`, `duration_minutes`
- **Genres:** `genre_id`, `genre_name`
- **MovieGenres:** `movie_id`, `genre_id`
- **ShowGenres:** `show_id`, `genre_id`
- **WatchHistory:** `history_id`, `profile_id`, `movie_id`, `episode_id`, `watched_at`, `progress_minutes`
- **Ratings:** `rating_id`, `profile_id`, `movie_id`, `show_id`, `rating`
- **Watchlist:** `watchlist_id`, `profile_id`, `movie_id`, `show_id`, `added_at`

## Entity Relationships

The principal relationships are:

- One **user** can have many **profiles**.
- One **user** can have many **subscription records**.
- One **subscription plan** can be referenced by many **subscriptions**.
- One **TV show** can have many **episodes**.
- Movies and genres have a many-to-many relationship through `MovieGenres`.
- TV shows and genres have a many-to-many relationship through `ShowGenres`.
- One **profile** can have many **watch-history entries**, **ratings**, and **watchlist entries**.
- A watch-history entry can refer to a movie or an episode.
- A rating and a watchlist entry can refer to a movie or a TV show.

### Relationship summary

| Parent | Child / junction | Cardinality |
|---|---|---|
| `Users` | `Profiles` | 1:N |
| `Users` | `Subscriptions` | 1:N |
| `SubscriptionPlans` | `Subscriptions` | 1:N |
| `TVShows` | `Episodes` | 1:N |
| `Movies` | `MovieGenres` | 1:N |
| `Genres` | `MovieGenres` | 1:N |
| `TVShows` | `ShowGenres` | 1:N |
| `Genres` | `ShowGenres` | 1:N |
| `Profiles` | `WatchHistory` | 1:N |
| `Profiles` | `Ratings` | 1:N |
| `Profiles` | `Watchlist` | 1:N |

## Normalization

The schema is intended to follow **Third Normal Form (3NF)** under the functional dependencies represented by the design.

### First Normal Form (1NF)

- Each column stores a single, atomic value.
- Repeating lists such as multiple genres are not stored in one field.
- Each table has a primary key or a composite key that identifies its rows.

For example, genres are stored in `Genres` and connected to movies through `MovieGenres`, rather than storing a comma-separated list of genres in `Movies`.

### Second Normal Form (2NF)

- The schema is in 1NF.
- In the junction tables `MovieGenres` and `ShowGenres`, each non-key attribute is absent; the composite key identifies each mapping.
- Movie details are stored in `Movies`, and genre details are stored in `Genres`, avoiding partial dependencies in the mapping tables.

### Third Normal Form (3NF)

- The schema is in 2NF.
- Plan details such as plan name and price are stored in `SubscriptionPlans`, not repeated in every subscription record.
- User, profile, movie, show, episode, and genre details are maintained in their respective tables rather than copied into activity tables.

This separation reduces update, insertion, and deletion anomalies. Additional business rules may require further constraints; see [Constraints and Design Notes](#constraints-and-design-notes).

## Getting Started

### Requirements

- MySQL Server 8.0 or later
- MySQL Workbench (recommended) or a MySQL CLI client

### Installation

1. Clone or download this project.
2. Open MySQL Workbench and connect to your MySQL server.
3. Open the SQL script containing the `CREATE DATABASE`, `CREATE TABLE`, and `INSERT` statements.
4. Execute the script.
5. Confirm that `NetflixDB` appears in the schema navigator.

If using the command line, run:

```bash
mysql -u your_username -p < netflix_database.sql
```

Replace `your_username` with your MySQL account name and `netflix_database.sql` with the actual SQL script filename. Enter your password when prompted.

To select the database after setup:

```sql
USE NetflixDB;
SHOW TABLES;
```

> The SQL script should be run against a database where these table names do not already exist. If you are rerunning it, remove the existing database only if you are comfortable deleting its data, or add appropriate `DROP TABLE IF EXISTS` / reset statements in dependency-safe order.

## Sample Data

The project seed data includes example accounts, subscription plans, subscriptions, profiles, movies, TV shows, episodes, genres, genre mappings, watch-history entries, ratings, and watchlist entries.

The sample records are fictional and intended only for testing. Some inserted subscription dates are illustrative and may not represent currently active subscriptions relative to the date you run the project.

After loading the data, inspect tables with:

```sql
SELECT * FROM Users;
SELECT * FROM Movies;
SELECT * FROM TVShows;
SELECT * FROM Subscriptions;
```

## Example SQL Queries

### 1. List all movies

```sql
SELECT *
FROM Movies;
```

### 2. Find movies in the Sci-Fi genre

```sql
SELECT m.title, g.genre_name
FROM Movies AS m
JOIN MovieGenres AS mg ON mg.movie_id = m.movie_id
JOIN Genres AS g ON g.genre_id = mg.genre_id
WHERE g.genre_name = 'Sci-Fi';
```

### 3. Display episodes for a TV show

```sql
SELECT
    s.title AS show_name,
    e.season_number,
    e.episode_number,
    e.title AS episode_name
FROM TVShows AS s
JOIN Episodes AS e ON e.show_id = s.show_id
WHERE s.title = 'Stranger Things'
ORDER BY e.season_number, e.episode_number;
```

### 4. List subscriptions with user and plan information

```sql
SELECT
    u.name,
    p.plan_name,
    p.price,
    sub.start_date,
    sub.end_date,
    sub.status
FROM Subscriptions AS sub
JOIN Users AS u ON u.user_id = sub.user_id
JOIN SubscriptionPlans AS p ON p.plan_id = sub.plan_id;
```

### 5. Calculate average movie ratings

```sql
SELECT
    m.title,
    AVG(r.rating) AS average_rating,
    COUNT(*) AS number_of_ratings
FROM Movies AS m
JOIN Ratings AS r ON r.movie_id = m.movie_id
GROUP BY m.movie_id, m.title;
```

### 6. Show a profile's watchlist

```sql
SELECT
    p.profile_name,
    m.title AS movie_title,
    s.title AS show_title,
    w.added_at
FROM Watchlist AS w
JOIN Profiles AS p ON p.profile_id = w.profile_id
LEFT JOIN Movies AS m ON m.movie_id = w.movie_id
LEFT JOIN TVShows AS s ON s.show_id = w.show_id
WHERE p.profile_id = 1;
```

### 7. Find users with active subscriptions

```sql
SELECT DISTINCT
    u.user_id,
    u.name,
    u.email
FROM Users AS u
JOIN Subscriptions AS sub ON sub.user_id = u.user_id
WHERE sub.status = 'Active';
```

## Relational Algebra

The project can also be described using relational algebra.

| Operation | Symbol | Example |
|---|---|---|
| Selection | `σ` | `σ_release_year > 2010 (Movies)` |
| Projection | `π` | `π_title, language (Movies)` |
| Join | `⋈` | `Users ⋈_Users.user_id = Subscriptions.user_id Subscriptions` |
| Union | `∪` | Combines union-compatible relations |
| Difference | `−` | Returns tuples in one relation but not another |
| Rename | `ρ` | Renames a relation or its attributes |

Example: retrieve the titles of Sci-Fi movies:

```text
π_Movies.title
  (σ_Genres.genre_name = 'Sci-Fi'
    ((Movies ⋈_Movies.movie_id = MovieGenres.movie_id MovieGenres)
      ⋈_MovieGenres.genre_id = Genres.genre_id Genres))
```

See the separate **Netflix Relational Algebra** notes/document for the complete set of table relations and query expressions.

## Constraints and Design Notes

The current schema provides primary keys, foreign keys, `NOT NULL` constraints on selected attributes, unique constraints for user email and genre name, and a rating range check.

For a more robust implementation, consider these additional rules:

- Ensure a `WatchHistory` row refers to exactly one of a movie or an episode.
- Ensure each `Ratings` row refers to exactly one of a movie or a TV show.
- Ensure each `Watchlist` row refers to exactly one of a movie or a TV show.
- Add uniqueness rules to prevent duplicate ratings or duplicate watchlist entries for the same profile and content, if that matches the intended behavior.
- Add checks for nonnegative progress, positive plan duration, positive device limits, and valid date ranges.
- Use a secure password-hashing mechanism in an application. The sample `password` column and seed values are for schema demonstration only; plaintext passwords must not be used in a real system.
- Consider whether subscription status should be constrained to a fixed set of values, or represented by a lookup table or an `ENUM`.

Some checks and constraints vary by MySQL version. Validate them against the server version used for the project.

## Possible Enhancements

- Add payment and transaction tables.
- Add content availability windows and regional licensing.
- Add content maturity ratings and profile-level restrictions.
- Add watch-progress timestamps and resume playback queries.
- Add indexes for frequently searched columns such as titles, foreign keys, and subscription status.
- Create views for active subscriptions, popular titles, and profile watch history.
- Add stored procedures and triggers for selected business rules.
- Build a frontend and backend application that uses this database.

## Project Structure

A suggested repository layout:

```text
netflix-database/
├── README.md
├── netflix_database.sql
├── relational_algebra.md
└── er_diagram.png
```

Use the actual filenames present in your repository. The SQL script, relational algebra notes, and ER diagram can be maintained as separate project artifacts.

## Disclaimer

This is an educational project inspired by common streaming-platform features. It is not affiliated with, endorsed by, or representative of Netflix, Inc. It does not contain Netflix proprietary data or reproduce its production database.
