
module sqld.ast.select_node;

import sqld.ast.from_node;
import sqld.ast.group_by_node;
import sqld.ast.having_node;
import sqld.ast.join_node;
import sqld.ast.limit_node;
import sqld.ast.offset_node;
import sqld.ast.order_by_node;
import sqld.ast.projection_node;
import sqld.ast.query_node;
import sqld.ast.visitor;
import sqld.ast.where_node;

import std.meta;

class SelectNode : QueryNode
{
    mixin Visitable;

private:
    ProjectionNode _projection;
    FromNode       _from;
    JoinNode[]     _joins;
    WhereNode      _where;
    GroupByNode    _groupBy;
    HavingNode     _having;
    OrderByNode    _orderBy;
    LimitNode      _limit;
    OffsetNode     _offset;

public:
    alias toSubquery this;

    this(ProjectionNode projection, FromNode from, JoinNode[] joins,  WhereNode where,
         GroupByNode groupBy, HavingNode having, OrderByNode orderBy, LimitNode limit, OffsetNode offset)
    {
        foreach(name; AliasSeq!("projection", "from", "joins", "where",
                                "groupBy", "having", "orderBy", "limit", "offset"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    ProjectionNode projection()
    {
        return _projection;
    }

    @property
    FromNode from()
    {
        return _from;
    }

    @property
    JoinNode[] joins()
    {
        return _joins;
    }

    @property
    WhereNode where()
    {
        return _where;
    }

    @property
    GroupByNode groupBy()
    {
        return _groupBy;
    }

    @property
    HavingNode having()
    {
        return _having;
    }

    @property
    OrderByNode orderBy()
    {
        return _orderBy;
    }

    @property
    LimitNode limit()
    {
        return _limit;
    }

    @property
    OffsetNode offset()
    {
        return _offset;
    }
}
