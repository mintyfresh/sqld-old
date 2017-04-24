
module sqld.partials.order_by_partial;

mixin template OrderByPartial()
{
    import sqld.ast;
    import std.meta : allSatisfy;

private:
    immutable(OrderByNode) _orderBy;

public:
    typeof(this) orderBy(immutable(OrderByNode) orderBy)
    {
        return next!("orderBy")(orderBy);
    }

    typeof(this) order(immutable(ExpressionListNode) directions)
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

    typeof(this) order(immutable(ExpressionNode)[] directions...)
    {
        return order(new immutable ExpressionListNode(directions));
    }

    typeof(this) reorder(TList...)(TList args)
    {
        return unorder.order(args);
    }

    typeof(this) unorder()
    {
        return orderBy(cast(OrderByNode) null);
    }
}
