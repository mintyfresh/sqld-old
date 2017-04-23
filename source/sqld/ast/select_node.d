
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

    this(const(ProjectionNode) projection, const(FromNode) from, const(JoinNode)[] joins,
         const(WhereNode) where, const(GroupByNode) groupBy, const(HavingNode) having,
         const(OrderByNode) orderBy, const(LimitNode) limit, const(OffsetNode) offset) const
    {
        foreach(name; AliasSeq!("projection", "from", "joins", "where",
                                "groupBy", "having", "orderBy", "limit", "offset"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    const(ProjectionNode) projection() const
    {
        return _projection;
    }

    @property
    const(FromNode) from() const
    {
        return _from;
    }

    @property
    const(JoinNode)[] joins() const
    {
        return _joins;
    }

    @property
    const(WhereNode) where() const
    {
        return _where;
    }

    @property
    const(GroupByNode) groupBy() const
    {
        return _groupBy;
    }

    @property
    const(HavingNode) having() const
    {
        return _having;
    }

    @property
    const(OrderByNode) orderBy() const
    {
        return _orderBy;
    }

    @property
    const(LimitNode) limit() const
    {
        return _limit;
    }

    @property
    const(OffsetNode) offset() const
    {
        return _offset;
    }
}
