
module sqld.ast.delete_node;

import sqld.ast.from_node;
import sqld.ast.limit_node;
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
    LimitNode     _limit;
    ReturningNode _returning;

public:
    this(immutable(FromNode) from, immutable(UsingNode) using, immutable(WhereNode) where,
         immutable(LimitNode) limit, immutable(ReturningNode) returning) immutable
    {
        foreach(name; AliasSeq!("from", "using", "where", "limit", "returning"))
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
    immutable(LimitNode) limit() immutable
    {
        return _limit;
    }

    @property
    immutable(ReturningNode) returning() immutable
    {
        return _returning;
    }
}
