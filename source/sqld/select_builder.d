
module sqld.select_builder;

import sqld.ast;
import sqld.window_builder;

struct JoinBuilder
{
private:
    SelectBuilder             _builder;
    JoinType                  _joinType;
    immutable(ExpressionNode) _source;

public:
    alias build this;

    this(SelectBuilder builder, JoinType joinType, immutable(ExpressionNode) source)
    {
        _builder  = builder;
        _joinType = joinType;
        _source   = source;
    }

    SelectBuilder build()
    {
        return _builder.join(_joinType, _source);
    }

    SelectBuilder on(immutable(ExpressionNode) condition)
    {
        return _builder.join(_joinType, _source, condition);
    }
}

struct SelectBuilder
{
private:
    immutable
    {
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
    }

public:
    alias build this;

    @property
    immutable(SelectNode) build()
    {
        return new immutable SelectNode(_projection, _from, _joins, _where, _groupBy,
                                        _having, _window, _orderBy, _limit, _offset);
    }

    /+ - Projection - +/

    SelectBuilder projection(immutable(ProjectionNode) projection)
    {
        return SelectBuilder(projection, _from, _joins, _where, _groupBy, _having,
                             _window, _orderBy, _limit, _offset);
    }

    SelectBuilder project(immutable(ExpressionNode)[] projection...)
    {
        return project(new immutable ExpressionListNode(projection));
    }

    SelectBuilder project(immutable(ExpressionListNode) projections)
    {
        if(_projection is null)
        {
            return projection(new immutable ProjectionNode(projections));
        }
        else
        {
            return projection(new immutable ProjectionNode(_projection.projections ~ projections));
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

    SelectBuilder from(immutable(FromNode) from)
    {
        return SelectBuilder(_projection, from, _joins, _where, _groupBy, _having,
                             _window, _orderBy, _limit, _offset);
    }

    SelectBuilder from(immutable(ExpressionNode)[] sources...)
    {
        if(_from is null)
        {
            return from(new immutable FromNode(sources));
        }
        else
        {
            return from(new immutable FromNode(_from.sources ~ sources));
        }
    }

    SelectBuilder from(immutable(ExpressionNode) source, string name)
    {
        return from(source.as(name));
    }

    SelectBuilder refrom(TList...)(TList args)
    {
        return unfrom.from(args);
    }

    SelectBuilder unfrom()
    {
        return from(cast(FromNode) null);
    }

    /+ - Join - +/

    SelectBuilder join(immutable(JoinNode) join)
    {
        return SelectBuilder(_projection, _from, _joins ~ join, _where, _groupBy, _having,
                             _window, _orderBy, _limit, _offset);
    }

    SelectBuilder join(JoinType joinType, immutable(ExpressionNode) source, immutable(ExpressionNode) condition)
    {
        return join(new immutable JoinNode(joinType, source, condition));
    }

    JoinBuilder join(JoinType joinType, immutable(ExpressionNode) source)
    {
        return JoinBuilder(this, joinType, source);
    }

    SelectBuilder join(immutable(ExpressionNode) source, immutable(ExpressionNode) condition)
    {
        return join(JoinType.inner, source, condition);
    }

    JoinBuilder join(immutable(ExpressionNode) source)
    {
        return JoinBuilder(this, JoinType.inner, source);
    }

    auto rejoin(TList...)(TList args)
    {
        return unjoin.join(args);
    }

    SelectBuilder unjoin()
    {
        return SelectBuilder(_projection, _from, [], _where, _groupBy, _having,
                             _window, _orderBy, _limit, _offset);
    }

    /+ - Where - +/

    SelectBuilder where(immutable(WhereNode) where)
    {
        return SelectBuilder(_projection, _from, _joins, where, _groupBy, _having,
                             _window, _orderBy, _limit, _offset);
    }

    SelectBuilder where(immutable(ExpressionNode) condition)
    {
        if(_where is null)
        {
            return where(new immutable WhereNode(condition));
        }
        else
        {
            return where(new immutable WhereNode(_where.clause.and(condition)));
        }
    }

    SelectBuilder rewhere(immutable(ExpressionNode) condition)
    {
        return unwhere.where(condition);
    }

    SelectBuilder unwhere()
    {
        return where(cast(WhereNode) null);
    }

    /+ - Group By - +/

    SelectBuilder groupBy(immutable(GroupByNode) groupBy)
    {
        return SelectBuilder(_projection, _from, _joins, _where, groupBy, _having,
                             _window, _orderBy, _limit, _offset);
    }

    SelectBuilder group(immutable(ExpressionNode)[] groupings...)
    {
        if(_groupBy is null)
        {
            return groupBy(new immutable GroupByNode(groupings));
        }
        else
        {
            return groupBy(new immutable GroupByNode(_groupBy.groupings ~ groupings));
        }
    }

    SelectBuilder regroup(immutable(ExpressionNode)[] groupings...)
    {
        return ungroup.group(groupings);
    }

    SelectBuilder ungroup()
    {
        return groupBy(null);
    }

    /+ - Having - +/

    SelectBuilder having(immutable(HavingNode) having)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, having,
                             _window, _orderBy, _limit, _offset);
    }

    SelectBuilder having(immutable(ExpressionNode) condition)
    {
        if(_having is null)
        {
            return having(new immutable HavingNode(condition));
        }
        else
        {
            return having(new immutable HavingNode(_having.clause.and(condition)));
        }
    }

    SelectBuilder rehaving(immutable(ExpressionNode) condition)
    {
        return unhaving.having(condition);
    }

    SelectBuilder unhaving()
    {
        return having(cast(HavingNode) null);
    }

    /+ - Window - +/

    SelectBuilder window(immutable(WindowNode) window)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, _having,
                             window, _orderBy, _limit, _offset);
    }

    SelectBuilder window(immutable(NamedWindowNode) namedWindow)
    {
        if(_window is null)
        {
            return window(new immutable WindowNode(namedWindow));
        }
        else
        {
            return window(new immutable WindowNode(_window.windows ~ namedWindow));
        }
    }

    SelectBuilder window(string name, immutable(WindowDefinitionNode) definition)
    {
        return window(new immutable NamedWindowNode(name, definition));
    }

    SelectBuilder window(string name, WindowBuilder delegate(WindowBuilder) callback)
    {
        return window(name, callback(WindowBuilder.init).build);
    }

    SelectBuilder rewindow(TList...)(TList args)
    {
        return unwindow.window(args);
    }

    SelectBuilder rewindow(alias callback)(string name)
    {
        return unwindow.window!(callback)(name);
    }

    SelectBuilder unwindow()
    {
        return window(cast(WindowNode) null);
    }

    /+ - Order By - +/

    SelectBuilder orderBy(immutable(OrderByNode) orderBy)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, _having,
                             _window, orderBy, _limit, _offset);
    }

    SelectBuilder order(immutable(ExpressionNode)[] directions...)
    {
        if(_orderBy is null)
        {
            return orderBy(new immutable OrderByNode(directions));
        }
        else
        {
            return orderBy(new immutable OrderByNode(_orderBy.directions ~ directions));
        }
    }

    SelectBuilder reorder(immutable(ExpressionNode)[] directions...)
    {
        return unorder.order(directions);
    }

    SelectBuilder unorder()
    {
        return orderBy(null);
    }

    /+ - Limit - +/

    SelectBuilder limit(immutable(LimitNode) value)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, _having,
                             _window, _orderBy, value, _offset);
    }

    SelectBuilder limit(ulong value)
    {
        return limit(new immutable LimitNode(value));
    }

    SelectBuilder unlimit()
    {
        return limit(null);
    }

    /+ - Offset - +/

    SelectBuilder offset(immutable(OffsetNode) value)
    {
        return SelectBuilder(_projection, _from, _joins, _where, _groupBy, _having,
                             _window, _orderBy, _limit, value);
    }

    SelectBuilder offset(ulong value)
    {
        return offset(new immutable OffsetNode(value));
    }

    SelectBuilder unoffset()
    {
        return offset(null);
    }
}
