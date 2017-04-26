
module sqld.ast.delete_node;

import sqld.ast.from_node;
import sqld.ast.limit_node;
import sqld.ast.query_node;
import sqld.ast.returning_node;
import sqld.ast.using_node;
import sqld.ast.visitor;
import sqld.ast.where_node;

import std.meta : AliasSeq;

immutable class DeleteNode : QueryNode
{
    mixin Visitable;

private:
    FromNode      _from;
    UsingNode     _using;
    WhereNode     _where;
    LimitNode     _limit;
    ReturningNode _returning;

public:
    this(immutable(FromNode) from, immutable(UsingNode) using, immutable(WhereNode) where,
         immutable(LimitNode) limit, immutable(ReturningNode) returning)
    {
        foreach(name; AliasSeq!("from", "using", "where", "limit", "returning"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    immutable(FromNode) from()
    {
        return _from;
    }

    @property
    immutable(UsingNode) using()
    {
        return _using;
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
