
module sqld.select_builder;

import sqld.ast;
import sqld.builder;
import sqld.partials;
import sqld.window_builder;

import std.meta : allSatisfy;

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
    mixin Builder;
    mixin WithPartial;
    mixin FromPartial;
    mixin WherePartial;
    mixin OrderByPartial;
    mixin LimitPartial;

private:
    immutable
    {
        ProjectionNode _projection;
        JoinNode[]     _joins;
        GroupByNode    _groupBy;
        HavingNode     _having;
        WindowNode     _window;
        OffsetNode     _offset;
    }

public:
    alias build this;

    @property
    immutable(SelectNode) build()
    {
        return new immutable SelectNode(_with_, _projection, _from, _joins, _where, _groupBy,
                                        _having, _window, _orderBy, _limit, _offset);
    }

    /+ - Projection - +/

    SelectBuilder projection(immutable(ProjectionNode) projection)
    {
        return next!("projection")(projection);
    }

    SelectBuilder select(immutable(ExpressionListNode) projections)
    {
        return projection(new immutable ProjectionNode(projections));
    }

    SelectBuilder select(immutable(ExpressionNode)[] projection...)
    {
        return select(new immutable ExpressionListNode(projection));
    }

    SelectBuilder select(TList...)(TList args) if(allSatisfy!(isExpressionType, TList))
    {
        return select(expressionList(args)); 
    }

    SelectBuilder unselect()
    {
        return projection(null);
    }

    /+ - Join - +/

    SelectBuilder join(immutable(JoinNode) join)
    {
        return next!("joins")(_joins ~ join);
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
        return next!("joins")(cast(immutable(JoinNode)[]) []);
    }

    /+ - Group By - +/

    SelectBuilder groupBy(immutable(GroupByNode) groupBy)
    {
        return next!("groupBy")(groupBy);
    }

    SelectBuilder group(immutable(ExpressionListNode) groupings)
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

    SelectBuilder group(immutable(ExpressionNode)[] groupings...)
    {
        return group(new immutable ExpressionListNode(groupings));
    }

    SelectBuilder regroup(TList...)(TList args)
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
        return next!("having")(having);
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
        return next!("window")(window);
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

    /+ - Offset - +/

    SelectBuilder offset(immutable(OffsetNode) offset)
    {
        return next!("offset")(offset);
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
