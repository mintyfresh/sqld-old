
module sqld.partials.from_partial;

mixin template FromPartial()
{
    import sqld.ast;

private:
    immutable(FromNode) _from;

public:
    typeof(this) from(immutable(FromNode) from)
    {
        return next!("from")(from);
    }

    typeof(this) from(immutable(ExpressionNode)[] sources...)
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

    typeof(this) from(immutable(ExpressionNode) source, string name)
    {
        return from(source.as(name));
    }

    typeof(this) refrom(TList...)(TList args)
    {
        return unfrom.from(args);
    }

    typeof(this) unfrom()
    {
        return from(cast(FromNode) null);
    }
}
