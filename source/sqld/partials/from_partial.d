
module sqld.partials.from_partial;

mixin template FromPartial()
{
    import sqld.ast;
    import sqld.select_builder;

private:
    immutable(FromNode) _from;

public:
    typeof(this) from(immutable(FromNode) from)
    {
        return next!("from")(from);
    }

    typeof(this) from(immutable(ExpressionListNode) sources)
    {
        return from(new immutable FromNode(sources));
    }

    typeof(this) from(immutable(ExpressionNode)[] sources...)
    {
        return from(new immutable ExpressionListNode(sources));
    }

    typeof(this) from(immutable(ExpressionNode) source, string name)
    {
        return from(source.as(name));
    }

    typeof(this) from(SelectBuilder delegate(SelectBuilder) callback, string name = "subquery")
    {
        return from(callback(SelectBuilder.init).as(name));
    }

    typeof(this) unfrom()
    {
        return from(cast(FromNode) null);
    }
}
