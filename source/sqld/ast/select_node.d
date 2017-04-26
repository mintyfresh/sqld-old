
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
import sqld.ast.window_node;
import sqld.ast.with_node;

import std.meta;

immutable class SelectNode : QueryNode
{
    mixin Visitable;

private:
    WithNode       _with_;
    ProjectionNode _projection;
    FromNode       _from;
    JoinNode[]     _joins;
    WhereNode      _where;
    GroupByNode    _groupBy;
    HavingNode     _having;
    WindowNode     _window;
    OrderByNode    _orderBy;
    LimitNode      _limit;
    OffsetNode     _offset;

public:
    alias toSubquery this;

    this(immutable(WithNode) with_, immutable(ProjectionNode) projection, immutable(FromNode) from,
         immutable(JoinNode)[] joins, immutable(WhereNode) where, immutable(GroupByNode) groupBy,
         immutable(HavingNode) having, immutable(WindowNode) window, immutable(OrderByNode) orderBy,
         immutable(LimitNode) limit, immutable(OffsetNode) offset)
    {
        foreach(name; AliasSeq!("with_", "projection", "from", "joins", "where", "groupBy", "having",
                                "window", "orderBy", "limit", "offset"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    immutable(WithNode) with_()
    {
        return _with_;
    }

    @property
    immutable(ProjectionNode) projection()
    {
        return _projection;
    }

    @property
    immutable(FromNode) from()
    {
        return _from;
    }

    @property
    immutable(JoinNode)[] joins()
    {
        return _joins;
    }

    @property
    immutable(WhereNode) where()
    {
        return _where;
    }

    @property
    immutable(GroupByNode) groupBy()
    {
        return _groupBy;
    }

    @property
    immutable(HavingNode) having()
    {
        return _having;
    }

    @property
    immutable(WindowNode) window()
    {
        return _window;
    }

    @property
    immutable(OrderByNode) orderBy()
    {
        return _orderBy;
    }

    @property
    immutable(LimitNode) limit()
    {
        return _limit;
    }

    @property
    immutable(OffsetNode) offset()
    {
        return _offset;
    }
}
