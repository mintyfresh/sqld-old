
module sqld.select_builder;

import sqld.ast;
import sqld.builder;
import sqld.partials;
import sqld.window_builder;

import std.meta : allSatisfy;

struct SelectBuilder
{
    mixin Builder;
    mixin WithPartial;
    mixin FromPartial;
    mixin JoinsPartial;
    mixin WherePartial;
    mixin OrderByPartial;
    mixin LimitPartial;

private:
    immutable
    {
        ProjectionNode _projection;
        GroupByNode    _groupBy;
        HavingNode     _having;
        WindowNode     _window;
        UnionNode      _union_;
        OffsetNode     _offset;
    }

public:
    alias build this;

    @property
    immutable(SelectNode) build()
    {
        return new immutable SelectNode(_with_, _projection, _from, _joins, _where, _groupBy,
                                        _having, _window, _union_, _orderBy, _limit, _offset);
    }

    /+ - Projection - +/

    SelectBuilder projection(immutable(ProjectionNode) projection)
    {
        return next!("projection")(projection);
    }

    SelectBuilder select(immutable(ExpressionListNode) projections)
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

    SelectBuilder select(immutable(ExpressionNode)[] projection...)
    {
        return select(new immutable ExpressionListNode(projection));
    }

    SelectBuilder select(TList...)(TList args) if(allSatisfy!(isExpressionType, TList))
    {
        return select(toExpressionList(args)); 
    }

    SelectBuilder reselect(TList...)(TList args)
    {
        return unselect.select(args);
    }

    SelectBuilder unselect()
    {
        return projection(null);
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

    SelectBuilder unwindow()
    {
        return window(cast(WindowNode) null);
    }

    /+ - Union - +/

    SelectBuilder union_(immutable(UnionNode) union_)
    {
        return next!("union_")(union_);
    }

    SelectBuilder union_(UnionType type, immutable(SelectNode) select)
    {
        return union_(new immutable UnionNode(type, select));
    }

    SelectBuilder union_(UnionType type, SelectDelegate callback)
    {
        return union_(type, toSelect(callback));
    }

    SelectBuilder union_(immutable(SelectNode) select)
    {
        return union_(new immutable UnionNode(select));
    }

    SelectBuilder union_(SelectDelegate callback)
    {
        return union_(toSelect(callback));
    }

    SelectBuilder ununion()
    {
        return union_(cast(UnionNode) null);
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

alias SelectDelegate = SelectBuilder delegate(SelectBuilder);

immutable(SelectNode) toSelect(SelectDelegate callback)
{
    return callback(SelectBuilder.init).build;
}
