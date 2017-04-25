
module sqld.partials.returning_partial;

mixin template ReturningPartial()
{
    import sqld.ast;
    import std.meta : allSatisfy;

private:
    immutable(ReturningNode) _returning;

public:
    typeof(this) returning(immutable(ReturningNode) returning)
    {
        return next!("returning")(returning);
    }

    typeof(this) returning(immutable(ExpressionListNode) outputs)
    {
        return returning(new immutable ReturningNode(outputs));
    }

    typeof(this) returning(immutable(ExpressionNode)[] outputs...)
    {
        return returning(new immutable ExpressionListNode(outputs));
    }

    typeof(this) returning(TList...)(TList args) if(allSatisfy!(isExpressionType, TList))
    {
        return returning(toExpressionList(args));
    }

    typeof(this) unreturning()
    {
        return returning(cast(ReturningNode) null);
    }
}
