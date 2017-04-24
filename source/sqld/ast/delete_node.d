
module sqld.ast.delete_node;

import sqld.ast.from_node;
import sqld.ast.query_node;
import sqld.ast.returning_node;
import sqld.ast.using_node;
import sqld.ast.visitor;
import sqld.ast.where_node;

import std.meta : AliasSeq;

class DeleteNode : QueryNode
{
    mixin Visitable;

private:
    FromNode      _from;
    UsingNode     _using;
    WhereNode     _where;
    ReturningNode _returning;

public:
    this(immutable(FromNode) from, immutable(UsingNode) using,
         immutable(WhereNode) where, immutable(ReturningNode) returning) immutable
    {
        foreach(name; AliasSeq!("from", "using", "where", "returning"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    immutable(FromNode) from() immutable
    {
        return _from;
    }

    @property
    immutable(UsingNode) using() immutable
    {
        return _using;
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
