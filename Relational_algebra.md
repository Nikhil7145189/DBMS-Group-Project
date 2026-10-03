
# Netflix DBMS Project — Relational Algebra

This document contains relational algebra expressions for the 13 tables in the Netflix database and useful queries based on the project schema.

## 1. Relations in the database

The database contains these relations:

- `Users(user_id, name, email, password, phone)`
- `SubscriptionPlans(plan_id, plan_name, price, duration_months, max_devices)`
- `Subscriptions(subscription_id, user_id, plan_id, start_date, end_date, status)`
- `Profiles(profile_id, user_id, profile_name, age_limit)`
- `Movies(movie_id, title, description, release_year, duration_minutes, language, country)`
- `TVShows(show_id, title, description, release_year, language, country)`
- `Episodes(episode_id, show_id, season_number, episode_number, title, duration_minutes)`
- `Genres(genre_id, genre_name)`
- `MovieGenres(movie_id, genre_id)`
- `ShowGenres(show_id, genre_id)`
- `WatchHistory(history_id, profile_id, movie_id, episode_id, watched_at, progress_minutes)`
- `Ratings(rating_id, profile_id, movie_id, show_id, rating)`
- `Watchlist(watchlist_id, profile_id, movie_id, show_id, added_at)`

## 2. Retrieve all records from each table

In relational algebra, a relation name by itself represents the full relation (all its attributes and tuples).

1. Users: `Users`
2. SubscriptionPlans: `SubscriptionPlans`
3. Subscriptions: `Subscriptions`
4. Profiles: `Profiles`
5. Movies: `Movies`
6. TVShows: `TVShows`
7. Episodes: `Episodes`
8. Genres: `Genres`
9. MovieGenres: `MovieGenres`
10. ShowGenres: `ShowGenres`
11. WatchHistory: `WatchHistory`
12. Ratings: `Ratings`
13. Watchlist: `Watchlist`

## 3. Useful relational algebra queries

The expressions below use **extended clarity with explicit join conditions**. A join written as `R ⋈condition S` means an equijoin on the stated condition. When attributes from multiple relations have the same name, qualify them with the relation name.

### Query 1 — Display all users

```text
π_user_id, name, email, phone (Users)
```

### Query 2 — Find users with active subscriptions

```text
π_Users.name, Users.email
  (σ_Subscriptions.status = 'Active'
    (Users ⋈_Users.user_id = Subscriptions.user_id Subscriptions))
```

### Query 3 — Display subscription plan names and prices

```text
π_plan_name, price (SubscriptionPlans)
```

### Query 4 — Find users subscribed to the Premium plan

```text
π_Users.name, Users.email
  (σ_SubscriptionPlans.plan_name = 'Premium'
    ((Users ⋈_Users.user_id = Subscriptions.user_id Subscriptions)
      ⋈_Subscriptions.plan_id = SubscriptionPlans.plan_id SubscriptionPlans))
```

### Query 5 — Display profiles belonging to user 1

```text
π_profile_name, age_limit (σ_user_id = 1 (Profiles))
```

### Query 6 — Find movies released after 2010

```text
σ_release_year > 2010 (Movies)
```

### Query 7 — Find TV shows released after 2020

```text
σ_release_year > 2020 (TVShows)
```

### Query 8 — Display all episodes of Stranger Things

```text
π_TVShows.title, Episodes.season_number, Episodes.episode_number, Episodes.title
  (σ_TVShows.title = 'Stranger Things'
    (TVShows ⋈_TVShows.show_id = Episodes.show_id Episodes))
```

For a report, rename the two title attributes in the output as `show_name` and `episode_name` if your course covers the rename operator.

### Query 9 — Find movies in the Sci-Fi genre

```text
π_Movies.title
  (σ_Genres.genre_name = 'Sci-Fi'
    ((Movies ⋈_Movies.movie_id = MovieGenres.movie_id MovieGenres)
      ⋈_MovieGenres.genre_id = Genres.genre_id Genres))
```

### Query 10 — Find TV shows in the Thriller genre

```text
π_TVShows.title
  (σ_Genres.genre_name = 'Thriller'
    ((TVShows ⋈_TVShows.show_id = ShowGenres.show_id ShowGenres)
      ⋈_ShowGenres.genre_id = Genres.genre_id Genres))
```

### Query 11 — Display watch history for profile 1

```text
π_watched_at, movie_id, episode_id, progress_minutes
  (σ_profile_id = 1 (WatchHistory))
```

### Query 12 — Find movies with a 5-star rating

```text
π_Movies.title
  (σ_Ratings.rating = 5
    (Movies ⋈_Movies.movie_id = Ratings.movie_id Ratings))
```

This query returns movies with a 5-star rating. It does not calculate average ratings.

### Query 13 — Display the watchlist for profile 1

```text
π_Profiles.profile_name, Watchlist.movie_id, Watchlist.show_id, Watchlist.added_at
  (σ_Profiles.profile_id = 1
    (Profiles ⋈_Profiles.profile_id = Watchlist.profile_id Watchlist))
```

## 4. Relational algebra symbols

| Symbol | Operation | Meaning |
|---|---|---|
| `σ` | Selection | Selects rows satisfying a condition |
| `π` | Projection | Selects specified columns |
| `⋈` | Join | Combines related rows from relations |
| `×` | Cartesian product | Pairs every row of one relation with every row of another |
| `∪` | Union | Combines union-compatible relations |
| `−` | Set difference | Returns tuples in one relation but not the other |
| `∩` | Intersection | Returns tuples common to both relations |
| `ρ` | Rename | Renames a relation or attributes |
| `÷` | Division | Finds tuples associated with every tuple in another relation |

## 5. Notes

- Relational algebra uses set semantics, so duplicate tuples are eliminated.
- A relation name by itself is the simplest expression for retrieving the whole table.
- Natural joins can be shorter, but explicit join conditions are safer here because several relations share attribute names such as `title`, `movie_id`, and `show_id`.
- The queries are based on the project schema and sample SQL queries. They are illustrative query expressions, not a claim that every business rule is enforced by the schema.
