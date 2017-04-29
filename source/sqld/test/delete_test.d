
module sqld.test.delete_test;

import sqld.ast;
import sqld.delete_builder;
import sqld.test.test_visitor;

@system unittest
{
    auto v = new TestVisitor;
    auto u = table("users");
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
    auto u = table("users");
    auto q = table("queues");
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

@system unittest
{
    auto v = new TestVisitor;
    auto u = table("users");
    auto w = table("warnings");
    auto b = DeleteBuilder.init;

    b.from(u)
     .using(s => s.select(u["id"].as("user_id"))
                  .from(u)
                  .join(w, w["user_id"].eq(u["id"]))
                  .group(u["id"])
                  .having(w["*"].count.gt(5)),
            w.name)
     .where(w["user_id"].eq(u["id"]))
     .returning(u["id"])
     .accept(v);

    assert(v.sql.squish == q{
        DELETE FROM
          users
        USING (
          SELECT
            users.id AS user_id
          FROM
            users
          INNER JOIN
            warnings
          ON
            warnings.user_id = users.id
          GROUP BY
            users.id
          HAVING
            COUNT(warnings.*) > 5
        ) AS warnings
        WHERE
          warnings.user_id = users.id
        RETURNING
          users.id
    }.squish);
}
