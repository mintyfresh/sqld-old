
module sqld.select_builder;

import sqld.ast;

struct JoinBuilder
{
private:
    SelectBuilder         _builder;
    JoinType              _joinType;
    const(ExpressionNode) _source;

public:
    alias builder this;

    this(SelectBuilder builder, JoinType joinType, const(ExpressionNode) source)
    {
        _builder  = builder;
        _joinType = joinType;
        _source   = source;
    }

    SelectBuilder builder()
    {
        return _builder.join(_joinType, _source);
    }

    SelectBuilder on(const(ExpressionNode) condition)
    {
        return _builder.join(_joinType, _source, condition);
    }
}

struct SelectBuilder
{
private:
    const
    {
        ProjectionNode _projection;
        FromNode       _from;
        JoinNode[]     _joins;
        WhereNode      _where;
        GroupByNode    _groupBy;
        HavingNode     _having;
        OrderByNode    _orderBy;
        LimitNode      _limit;
        OffsetNode     _offset;
    }

public:
    @property
    const(SelectNode) build()
    {
        return new const SelectNode(_projection, _from, _joins, _where, _groupBy,
                                    _having, _orderBy, _limit, _offset);
    }

    /+ - Projection - +/

    SelectBuilder projection(const(ProjectionNode) projection)
    {
        return SelectBuilder(projection, _from, _joins, _where, _groupBy, _having, _orderBy, _limit, _offset);
    }

    SelectBuilder project(const(ExpressionNode)[] projection...)
    {
        return project(new const ExpressionListNode(projection));
    }

    SelectBuilder project(const(ExpressionListNode) projections)
    {
        if(_projection is null)
        {
            return projection(new const ProjectionNode(projections));
        }
        else
        {
            return projection(new const ProjectionNode(_projection.projections ~ projections));
        }
    }

    SelectBuilder reproject(TList...)(TList args)
    {
        return unproject.project(args);
    }

    SelectBuilder unproject()
    {
        return projection(null);
    }

    /+ - From - +/

    SelectBuilder from(const(FromNode) from)
    {
        return SelectBuilder(_projection, from, _joins, _where, _groupBy, _having, _orderBy, _limit, _offset);
    }

    SelectBuilder from(const(ExpressionNode) source, string name = null)
    {
        auto value = name ? new const AsNode(source, name) : source;

        if(_from is null)
        {
            return from(new const FromNode(value));
        }
        else
        {
            return from(new const FromNode(_from.sources ~ value));
        }
    }

    SelectBuilder refrom(const(ExpressionNode) node, string name = null)
    {
        return unfrom.from(node, name);
    }

    SelectBuilder unfrom()
    {
        return from(cast(FromNode) null);
    }

    /+ - Join - +/

    SelectBuilder join(const(JoinNode) join)
    {
        return SelectBuilder(_projection, _from, _joins ~ join, _where, _groupBy, _having, _orderBy, _limit, _offset);
    }

    SelectBuilder join(JoinType joinType, const(ExpressionNode) source, const(ExpressionNode) condition)
    {
        return join(new const JoinNode(joinType, source, condition));
    }

    JoinBuilder join(JoinType joinType, const(ExpressionNode) source)
    {
        return JoinBuilder(this, joinType, source);
    }

    SelectBuilder join(const(ExpressionNode) source, const(ExpressionNode) condition)
    {
        return join(JoinType.inner, source, condition);
    }

    JoinBuilder join(const(ExpressionNode) source)
    {
        return JoinBuilder(this, JoinType.inner, source);
    }

    auto rejoin(TList...)(TList args)
    {
        return unjoin.join(args);
    }

    SelectBuilder unjoin()
    {
        return SelectBuilder(_projection, _from, [], _where, _groupBy, _having, _orderBy, _limit, _offset);
    }

    /+ - Where - +/

    SelectBuilder where(const(WhereNode) where)
    {
        return SelectBuilder(_projection, _from, _joins, where, _groupBy, _having, _orderBy, _limit, _offset);
    }

    SelectBuilder where(const(ExpressionNode) condition)
    {
        if(_where is null)
        {
            return where(new const WhereNode(condition));
        }
        else
        {
            return where(new const WhereNode(_where.clause.and(condition)));
        }
    }

    SelectBuilder rewhere(const(ExpressionNode) condition)
    {
        return unwhere.where(condition);
    }

    SelectBuilder unwhere()
    {
        return where(cast(WhereNode) null);
    }

    /+ - Group By - +/

    SelectBuilder groupBy(GroupByNode groupBy)
    {
        return SelectBuilder(_projection, _from, _joins, _where, groupBy, _having, _orderBy, _limit, _offset);
    }

    SelectBuilder group(T : ExpressionNode)(T groupings)
    {
        if(_groupBy is null)
        {
            return groupBy(new GroupByNode(groupings));
        }
        else
        {
            return groupBy(new GroupByNode(_groupBy.groupings ~ groupings));
        }
    }

    SelectBuilder regroup(T : ExpressionNode)(T groupings)
    {
        return ungroup.group(groupings);
    }

    SelectBuilder ungroup()
    {
        return groupBy(null);
    }

    /+ - Having - +/

    SelectBuilder having(const(HavingNode) having)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, having, _orderBy, _limit, _offset);
    }

    SelectBuilder having(const(ExpressionNode) condition)
    {
        if(_having is null)
        {
            return having(new const HavingNode(condition));
        }
        else
        {
            return having(new const HavingNode(_having.clause.and(condition)));
        }
    }

    SelectBuilder rehaving(const(ExpressionNode) condition)
    {
        return unhaving.having(condition);
    }

    SelectBuilder unhaving()
    {
        return having(cast(HavingNode) null);
    }

    /+ - Order By - +/

    SelectBuilder orderBy(const(OrderByNode) orderBy)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, _having, orderBy, _limit, _offset);
    }

    SelectBuilder order(T : ExpressionNode)(T directions)
    {
        if(_orderBy is null)
        {
            return orderBy(new OrderByNode(directions));
        }
        else
        {
            return orderBy(new OrderByNode(_orderBy.directions ~ directions));
        }
    }

    SelectBuilder reorder(T : ExpressionNode)(T directions)
    {
        return unorder.order(directions);
    }

    SelectBuilder unorder()
    {
        return orderBy(null);
    }

    /+ - Limit - +/

    SelectBuilder limit(const(LimitNode) value)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, _having, _orderBy, value, _offset);
    }

    SelectBuilder limit(ulong value)
    {
        return limit(new LimitNode(value));
    }

    SelectBuilder unlimit()
    {
        return limit(null);
    }

    /+ - Offset - +/

    SelectBuilder offset(const(OffsetNode) value)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, _having, _orderBy, _limit, value);
    }

    SelectBuilder offset(ulong value)
    {
        return offset(new OffsetNode(value));
    }

    SelectBuilder unoffset()
    {
        return offset(null);
    }
}
