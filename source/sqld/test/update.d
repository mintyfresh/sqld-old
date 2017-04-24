
module sqld.test.update;

import sqld.ast;
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
