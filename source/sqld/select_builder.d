
module sqld.select_builder;

import sqld.ast;

struct JoinBuilder
{
private:
    SelectBuilder  _builder;
    JoinType       _joinType;
    ExpressionNode _source;

public:
    alias _builder this;

    this(SelectBuilder builder, JoinType joinType, ExpressionNode source)
    {
        _builder  = builder;
        _joinType = joinType;
        _source   = source;
    }

    SelectBuilder on(ExpressionNode condition)
    {
        _builder._joins ~= new JoinNode(_joinType, _source, condition);

        return _builder;
    }
}

class SelectBuilder
{
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
    /+ - Projection - +/

    SelectBuilder projection(ProjectionNode projection)
    {
        _projection = projection;

        return this;
    }

    SelectBuilder project(ExpressionNode[] projection...)
    {
        return project(new ExpressionListNode(projection));
    }

    SelectBuilder project(ExpressionListNode projections)
    {
        if(_projection is null)
        {
            return projection(new ProjectionNode(projections));
        }
        else
        {
            return projection(new ProjectionNode(_projection.projections ~ projections));
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

    SelectBuilder from(FromNode from)
    {
        _from = from;

        return this;
    }

    SelectBuilder from(ExpressionNode source, string name = null)
    {
        if(name !is null)
        {
            source = new AsNode(source, name);
        }

        if(_from is null)
        {
            return from(new FromNode(source));
        }
        else
        {
            return from(new FromNode(_from.sources ~ source));
        }
    }

    SelectBuilder refrom(ExpressionNode node, string name = null)
    {
        return unfrom.from(node, name);
    }

    SelectBuilder unfrom()
    {
        return from(cast(FromNode) null);
    }

    /+ - Join - +/

    SelectBuilder join(JoinNode join)
    {
        _joins ~= join;

        return this;
    }

    SelectBuilder join(JoinType joinType, ExpressionNode source, ExpressionNode condition)
    {
        return join(new JoinNode(joinType, source, condition));
    }

    JoinBuilder join(JoinType joinType, ExpressionNode source)
    {
        return JoinBuilder(this, joinType, source);
    }

    SelectBuilder join(ExpressionNode source, ExpressionNode condition)
    {
        return join(JoinType.inner, source, condition);
    }

    JoinBuilder join(ExpressionNode source)
    {
        return JoinBuilder(this, JoinType.inner, source);
    }

    auto rejoin(TList...)(TList args)
    {
        return unjoin.join(args);
    }

    SelectBuilder unjoin()
    {
        _joins = [];

        return this;
    }

    /+ - Where - +/

    SelectBuilder where(WhereNode where)
    {
        _where = where;

        return this;
    }

    SelectBuilder where(ExpressionNode condition)
    {
        if(_where is null)
        {
            return where(new WhereNode(condition));
        }
        else
        {
            return where(new WhereNode(_where.clause.and(condition)));
        }
    }

    SelectBuilder rewhere(ExpressionNode condition)
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
        _groupBy = groupBy;

        return this;
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

    SelectBuilder having(HavingNode having)
    {
        _having = having;

        return this;
    }

    SelectBuilder having(ExpressionNode condition)
    {
        if(_having is null)
        {
            return having(new HavingNode(condition));
        }
        else
        {
            return having(new HavingNode(_having.clause.and(condition)));
        }
    }

    SelectBuilder rehaving(ExpressionNode condition)
    {
        return unhaving.having(condition);
    }

    SelectBuilder unhaving()
    {
        return having(cast(HavingNode) null);
    }

    /+ - Order By - +/

    SelectBuilder orderBy(OrderByNode orderBy)
    {
        _orderBy = orderBy;

        return this;
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

    SelectBuilder limit(LimitNode value)
    {
        _limit = value;

        return this;
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

    SelectBuilder offset(OffsetNode value)
    {
        _offset = value;

        return this;
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
