
module sqld.test.select;

import sqld.ast;
import sqld.select_builder;
import sqld.test.test_visitor;

@system unittest
{
    auto v = new TestVisitor;
    auto b = new SelectBuilder;
    auto u = new TableNode("users");
    auto p = new TableNode("posts");

    b.project(u["*"])
     .from(u)
     .join(p, p["user_id"].eq(u["id"]))
     .where(u["active"])
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
          users.active
        LIMIT
          10
    }.squish);
}
