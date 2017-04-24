
module sqld.partials.returning_partial;

mixin template ReturningPartial()
{
    import sqld.ast;

private:
    immutable(ReturningNode) _returning;

public:
    typeof(this) returning(immutable(ReturningNode) returning)
    {
        return next!("returning")(returning);
    }

    typeof(this) returning(immutable(ExpressionNode)[] outputs...)
    {
        if(_returning is null)
        {
            return returning(new immutable ReturningNode(outputs));
        }
        else
        {
            return returning(new immutable ReturningNode(_returning.outputs ~ outputs));
        }
    }

    typeof(this) rereturning(immutable(ExpressionNode) outputs)
    {
        return unreturning.returning(outputs);
    }

    typeof(this) unreturning()
    {
        return returning(cast(ReturningNode) null);
    }
}
