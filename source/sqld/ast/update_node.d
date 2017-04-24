
module sqld.ast.update_node;

import sqld.ast.from_node;
import sqld.ast.node;
import sqld.ast.returning_node;
import sqld.ast.set_node;
import sqld.ast.table_node;
import sqld.ast.visitor;
import sqld.ast.where_node;

import std.meta : AliasSeq;

class UpdateNode : Node
{
    mixin Visitable;

private:
    TableNode     _table;
    SetNode       _set;
    FromNode      _from;
    WhereNode     _where;
    ReturningNode _returning;

public:
    this(immutable(TableNode) table, immutable(SetNode) set, immutable(FromNode) from,
         immutable(WhereNode) where, immutable(ReturningNode) returning) immutable
    {
        foreach(name; AliasSeq!("table", "set", "from", "where", "returning"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    immutable(TableNode) table() immutable
    {
        return _table;
    }

    @property
    immutable(SetNode) set() immutable
    {
        return _set;
    }

    @property
    immutable(FromNode) from() immutable
    {
        return _from;
    }

    @property
    immutable(WhereNode) where() immutable
    {
        return _where;
    }

    @property
    immutable(ReturningNode) returning() immutable
    {
        return _returning;
    }
}
