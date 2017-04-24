
module sqld.test.delete_test;

import sqld.ast;
import sqld.delete_builder;
import sqld.test.test_visitor;

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto b = DeleteBuilder.init;

    b.from(u)
     .where(u["active"].eq(false))
     .returning(u["id"])
     .accept(v);

    assert(v.sql.squish == q{
        DELETE FROM
          users
        WHERE
          users.active = false
        RETURNING
          users.id
    }.squish);
}

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto q = TableNode("queues");
    auto b = DeleteBuilder.init;

    b.from(q)
     .using(u)
     .where(q["user_id"].eq(u["id"]))
     .where(u["active"].eq(true))
     .returning(q["id"])
     .accept(v);

    assert(v.sql.squish == q{
        DELETE FROM
          queues
        USING
          users
        WHERE
          queues.user_id = users.id
        AND
          users.active = true
        RETURNING
          queues.id
    }.squish);
}
