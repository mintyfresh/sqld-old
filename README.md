# SQLD
SQLD is a mid-level framework for constructing SQL queries.
Notably, it:
 * Abstracts differences between Database Systems.
 * Uses an `immutable` AST for safe re-use of partials, even in a concurrent environment.
 * Bridges the gap between SQL and D with an expressive and intuitive notation.

Specifically, SQLD is mid-level because it's intended to sit between the Database Adapter and an ORM or some other persistence framework. However, it's perfectly suitable for use directly. The only caveat is that SQLD does not offer any sort of drivers or adapters for connecting to a Database.

## Introduction
Here's a demo of some of the features SQLD supports.
The SQL output in the examples is given in PostgreSQL syntax, but other Database Systems can be used just the same.

A simple SELECT query can we written like this:
```d
auto users = table("users");
auto query = SQLD.select(sql("*")).from(users);
```

And would produce this SQL:
```sql
SELECT * FROM "users"
```

### Joins
The notation for JOIN operations in SQLD follows the same structure as SQL:
```d
SQLD.select(sql("*"))
    .from(users)
    .join(posts)
    .on(posts["user_id"].eq(users["id"]));
```

Which produces the following join statement and condition:
```sql
SELECT * FROM "users" INNER JOIN "posts" ON "posts"."user_id" = "users"."id"
```

The `.on()` condition may also be written as part of the `.join()` call:
```d
SQLD.select(sql("*"))
    .from(users)
    .join(posts, posts["user_id"].eq(users["id"]));
```

### Outer Joins
While `INNER JOIN` is the kind performed by default, other types are also supported.
For example, to do a `LEFT OUTER JOIN`:
```d
SQLD.select(sql("*"))
    .from(users)
    .join(JoinType.left, posts)
    .on(posts["user_id"].eq(users["id"]));
```

Which produces the following left join:
```sql
SELECT * FROM "users" LEFT OUTER JOIN "posts" ON "posts"."user_id" = "users"."id"
```

SQLD supports inner joins, as well as left, right, and full outer joins.
`CROSS JOIN` is also supported, but the join condition must be omitted.

### Subqueries
```d
auto subquery = table("subquery");

auto query = SQLD.select(users["id"], posts["*"].count)
                 .from(users)
                 .join(posts, posts["user_id"].eq(users["id"]))
                 .group(users["id"]);

SQLD.select(subquery["count"])
    .from(query.as(subquery))
    .where(subquery["count"].gtEq(5));
```

```sql
SELECT
    "subquery"."count"
FROM (
    SELECT
        "users"."id", COUNT("posts".*)
    FROM
        "users"
    INNER JOIN
        "posts"
    ON
        "posts"."user_id" = "users"."id"
    GROUP BY
        "users"."id"
) AS "subquery"
WHERE
    "subquery"."count" >= 5
```

Subqueries can also be written inline using a callback:
```d
auto subquery = table("subquery");

SQLD.select(subquery["count"])
    .from(s => s.select(users["id"], posts["*"].count)
                .from(users)
                .join(posts, posts["user_id"].eq(users["id"])))
                .group(users["id"]),
          subquery)
    .where(subquery["count"].gtEq(5));
```

### Arithmetic
SQLD uses the much the same syntax for arithmetic as is used in D:
```d
SQLD.select(users["id"], users["balance"] + users["credit"])
    .from(users);
```

Which produces the following SQL output:
```sql
SELECT
    "users"."id",
    "users"."balance" + "users"."credit"
FROM
    "users"
```

SQLD supports the following binary arithmetic operators: `+ - * / % << >> & | ^`

### Common Table Expressions
```d
auto cte = table("cte");

SQLD.select(cte["user_id"])
    .from(cte)
    .cte(cte, s => s.select(users["id"].as("user_id"))
                    .from(users));
```

```sql
WITH "cte" AS (
    SELECT
        "users"."id" AS "user_id"
    FROM
        "users"
)
SELECT
    "cte"."user_id"
FROM
    "cte"
```

### Window Functions
```d
SQLD.select(users["id"]
            func("first_value", posts["id"]).over(w =>
                w.partition(users["id"])
                 .order(posts["created_at"].asc)))
    .from(users)
    .join(posts, posts["user_id"].eq(users["id"]));
```

```sql
SELECT
    "users"."id",
    first_value("posts"."id") OVER (
        PARTITION BY "users"."id" ORDER BY "posts"."created_at" ASC
    )
FROM
    "users"
INNER JOIN
    "posts"
ON
    "posts"."user_id" = "users"."id"
```

SQLD also supports defining windows at query level, which is helpful when calling multiple functions over the same window.
So if we wanted to modify the previous example to also include each users' last post, we could use a query level window clause:
```d
SQLD.select(users["id"],
            func("first_value", posts["id"]).over("first_posts"),
            func("last_value", posts["id"]).over("first_posts"))
    .from(users)
    .from(users)
    .join(posts, posts["user_id"].eq(users["id"]))
    .window("first_posts", w => w.partition(users["id"])
                                 .order(posts["created_at"].asc));
```

Which produces the following SQL output:
```sql
SELECT
    "users"."id",
    first_value("posts"."id") OVER "first_posts",
    last_value("posts"."id") OVER "first_posts"
FROM
    "users"
INNER JOIN
    "posts"
ON
    "posts"."user_id" = "users"."id"
WINDOW
    "first_posts" AS (
        PARTITION BY "users"."id" ORDER BY "posts"."created_at" ASC
    )
```

### Inline SQL
SQLD also supports using inline syntax, which may sometimes be necessary for features too complex (or simply unsupported) by the AST.
As a simple example:
```d
SQLD.select(column("day_of_year"))
    .from(sql("generate_series(current_date - interval '1 year', current_date, interval '1 day')").as("day_of_year"));
```

Can be used to produce the following SQL query:
```sql
SELECT
  "day_of_year"
FROM
  generate_series(current_date - interval '1 year', current_date, interval '1 day') AS "day_of_year"
```

## Query Generators
SQLD doesn't do its own query generation. It just builds the query AST, which is handed off to a query Generator. Generators are libraries implement the SQLD AST-Visitor API, and produce SQL queries from a constructed (or partial) AST.

Below is a list of Generators, and the Database Systems they support:
 * [SQLD-Postgres](https://github.com/Mihail-K/sqld-postgres) - PostgreSQL

## Inspiration
SQLD takes some queues from [Arel](https://github.com/rails/arel), a similar framework for Ruby and Rails. However, there are some key differences.

Notably, SQLD:
 * Doesn't rely on another library or framework.
 * Uses a fully `immutable` AST for thread safety.
 * Decouples itself from query generation. Instead, a modular system of Database specific generator libraries is used.

## License
SQLD is released under the [MIT License](http://www.opensource.org/licenses/MIT).
