
module sqld.test.select;

import sqld.ast;
import sqld.select_builder;
import sqld.test.test_visitor;

@system unittest
{
    auto v = new TestVisitor;
    auto b = new SelectBuilder;
    auto u = new const TableNode("users");
    auto p = new const TableNode("posts");

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
    auto u = new const TableNode("users");
    auto p = new const TableNode("posts");

    auto b1 = new SelectBuilder;
    auto b2 = new SelectBuilder;

    b2.project(u["*"])
      .from(u)
      .where(u["id"] in
          b1.project(p["user_id"])
            .from(p)
            .where(p["reported"].eq(true))
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
          )
        LIMIT
          10
    }.squish);
}
