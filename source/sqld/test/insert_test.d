
module sqld.test.insert_test;

import sqld.ast;
import sqld.insert_builder;
import sqld.test.test_visitor;

@system unittest
{
    auto v = new TestVisitor;
    auto u = TableNode("users");
    auto b = InsertBuilder.init;

    b.into(u, ["active", "banned"])
     .values(true, false)
     .returning(u["id"])
     .accept(v);

    assert(v.sql.squish == q{
        INSERT INTO
          users(active, banned)
        VALUES
          (true, false)
        RETURNING
          users.id
    }.squish);
}
