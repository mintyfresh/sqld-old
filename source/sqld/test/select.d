
module sqld.test.select;

import sqld.ast;
import sqld.select_builder;
import sqld.test.test_visitor;

@system unittest
{
    auto v = new TestVisitor;
    auto b = SelectBuilder.init;
    auto u = TableNode("users");
    auto p = TableNode("posts");

    b.project(u["*"])
     .from(u)
     .join(p, p["user_id"].eq(u["id"]))
     .where(u["active"].eq(true))
     .limit(10)
     .build
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

    b2.project(u["*"])
      .from(u)
      .where(u["id"] in
          b1.project(p["user_id"])
            .from(p)
            .where(p["reported"].eq(true))
            .group(p["user_id"])
            .having(p["*"].count.eq(3))
            .order(p["*"].count.desc)
            .build)
      .limit(10)
      .build
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
              COUNT(posts.*) = 3
            ORDER BY
              COUNT(posts.*) DESC
          )
        LIMIT
          10
    }.squish);
}
