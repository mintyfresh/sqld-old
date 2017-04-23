
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
    inout(ProjectionNode) projection() inout
    {
        return _projection;
    }

    @property
    inout(FromNode) from() inout
    {
        return _from;
    }

    @property
    inout(JoinNode)[] joins() inout
    {
        return _joins;
    }

    @property
    inout(WhereNode) where() inout
    {
        return _where;
    }

    @property
    inout(GroupByNode) groupBy() inout
    {
        return _groupBy;
    }

    @property
    inout(HavingNode) having() inout
    {
        return _having;
    }

    @property
    inout(OrderByNode) orderBy() inout
    {
        return _orderBy;
    }

    @property
    inout(LimitNode) limit() inout
    {
        return _limit;
    }

    @property
    inout(OffsetNode) offset() inout
    {
        return _offset;
    }
}
