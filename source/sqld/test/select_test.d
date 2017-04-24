
module sqld.test.select;

import sqld.ast;
import sqld.select_builder;
import sqld.test.test_visitor;

@system unittest
{
    auto v = new TestVisitor;
    auto b = SelectBuilder.init;
    auto u = TableNode("users");

    b.select(u["id"])
     .from(u)
     .where(u["posts_count"].gt(5))
     .where(u["active"].eq(false))
     .where(u["bans_count"].ltEq(3))
     .accept(v);

    assert(v.sql == q{
        SELECT
          users.id
        FROM
          users
        WHERE
          users.posts_count > 5
        AND
          users.active = false
        AND
          users.bans_count <= 3
    }.squish);
}

@system unittest
{
    auto v = new TestVisitor;
    auto b = SelectBuilder.init;
    auto u = TableNode("users");
    auto p = TableNode("posts");

    b.select(u["*"])
     .from(u)
     .join(p, p["user_id"].eq(u["id"]))
     .where(u["active"].eq(true))
     .limit(10)
     .accept(v);
    
    assert(v.sql == q{
        SELECT
          users.*
        FROM
          users
        INNER JOIN
          posts
        ON
          posts.user_id = users.id
        WHERE
          users.active = true
        LIMIT
          10
    }.squish);
}

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto p = TableNode("posts");

    auto b1 = SelectBuilder.init;
    auto b2 = SelectBuilder.init;

    b2.select(u["*"])
      .from(u)
      .where(u["id"] in
          b1.select(p["user_id"])
            .from(p)
            .where(p["reported"].eq(true))
            .group(p["user_id"])
            .having(p["*"].count.gtEq(3))
            .order(p["*"].count.desc))
      .limit(10)
      .accept(v);

    assert(v.sql == q{
        SELECT
          users.*
        FROM
          users
        WHERE
          users.id IN (
            SELECT
              posts.user_id
            FROM
              posts
            WHERE
              posts.reported = true
            GROUP BY
              posts.user_id
            HAVING
              COUNT(posts.*) >= 3
            ORDER BY
              COUNT(posts.*) DESC
          )
        LIMIT
          10
    }.squish);
}

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto b = SelectBuilder.init;

    b.select(u["posts_count"].sum.over(w => w.partition(u["status"])))
     .from(u)
     .accept(v);

    assert(v.sql == q{
        SELECT
          SUM(users.posts_count) OVER (
            PARTITION BY users.status
          )
        FROM
          users
    }.squish);
}

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto p = TableNode("posts");
    auto b = SelectBuilder.init;

    b.select(u["*"],
             p["id"].count.over("user_window").as("posts_count"))
     .from(u)
     .join(JoinType.left, p, p["user_id"].eq(u["id"]))
     .window("user_window", w => w.partition(u["id"]))
     .accept(v);

    assert(v.sql == q{
        SELECT
          users.*,
          COUNT(posts.id) OVER user_window AS posts_count
        FROM
          users
        LEFT OUTER JOIN
          posts
        ON
          posts.user_id = users.id
        WINDOW
          user_window AS (
            PARTITION BY users.id
          )
    }.squish);
}