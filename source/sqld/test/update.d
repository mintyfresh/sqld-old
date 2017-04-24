
module sqld.test.update;

import sqld.ast;
import sqld.select_builder;
import sqld.test.test_visitor;
import sqld.update_builder;

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto b = UpdateBuilder.init;

    b.table(u)
     .set("banned", true)
     .set("active", false)
     .where(u["warnings_count"].gtEq(10))
     .build
     .accept(v);

    assert(v.sql == q{
        UPDATE
          users
        SET
          banned = true,
          active = false
        WHERE
          users.warnings_count >= 10
    }.squish);
}

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto p = TableNode("posts");
    auto b = UpdateBuilder.init;

    b.table(u)
     .set("banned", true)
     .set("active", false)
     .from(p)
     .where(p["user_id"].eq(u["id"]))
     .where(p["inappropriate"].eq(true))
     .returning(u["id"], u["email"])
     .build
     .accept(v);

    assert(v.sql == q{
        UPDATE
          users
        SET
          banned = true,
          active = false
        FROM
          posts
        WHERE
          posts.user_id = users.id
        AND
          posts.inappropriate = true
        RETURNING
          users.id,
          users.email
    }.squish);
}

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto p = TableNode("posts");

    auto b1 = UpdateBuilder.init;
    auto b2 = SelectBuilder.init;

    b1.table(u)
      .set("posts_count", p["count"])
      .from(b2.project(p["user_id"], p["*"].count)
              .from(p)
              .group(p["user_id"])
              .build
              .as(p.name))
      .where(p["user_id"].eq(u["id"]))
      .build
      .accept(v);

    assert(v.sql == q{
        UPDATE
          users
        SET
          posts_count = posts.count
        FROM (
          SELECT
            posts.user_id,
            COUNT(posts.*)
          FROM
            posts
          GROUP BY
            posts.user_id
        ) AS posts
        WHERE
          posts.user_id = users.id
    }.squish);
}
