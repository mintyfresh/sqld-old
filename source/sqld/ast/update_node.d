
module sqld.ast.update_node;

import sqld.ast.from_node;
import sqld.ast.limit_node;
import sqld.ast.query_node;
import sqld.ast.returning_node;
import sqld.ast.set_node;
import sqld.ast.table_node;
import sqld.ast.visitor;
import sqld.ast.where_node;

import std.meta : AliasSeq;

immutable class UpdateNode : QueryNode
{
    mixin Visitable;

private:
    TableNode     _table;
    SetNode       _set;
    FromNode      _from;
    WhereNode     _where;
    LimitNode     _limit;
    ReturningNode _returning;

public:
    this(immutable(TableNode) table, immutable(SetNode) set, immutable(FromNode) from,
         immutable(WhereNode) where, immutable(LimitNode) limit, immutable(ReturningNode) returning)
    {
        foreach(name; AliasSeq!("table", "set", "from", "where", "limit", "returning"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    immutable(TableNode) table()
    {
        return _table;
    }

    @property
    immutable(SetNode) set()
    {
        return _set;
    }

    @property
    immutable(FromNode) from()
    {
        return _from;
    }

    @property
    immutable(WhereNode) where()
    {
        return _where;
    }

    @property
    immutable(LimitNode) limit()
    {
        return _limit;
    }

    @property
    immutable(ReturningNode) returning()
    {
        return _returning;
    }
}
