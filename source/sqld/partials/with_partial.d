
module sqld.partials.with_partial;

mixin template WithPartial()
{
    import sqld.ast;
    import sqld.select_builder;

private:
    immutable(WithNode) _with_;

public:
    typeof(this) with_(immutable(WithNode) with_)
    {
        return next!("with_")(with_);
    }

    typeof(this) cte(bool recursive, immutable(TableNode) table, immutable(SelectNode) select)
    {
        return with_(new immutable WithNode(recursive, table, select));
    }

    typeof(this) cte(immutable(TableNode) table, immutable(SelectNode) select)
    {
        return cte(false, table, select);
    }

    typeof(this) cte(bool recursive, immutable(TableNode) table, SelectDelegate callback)
    {
        return cte(recursive, table, toSelect(callback));
    }

    typeof(this) cte(immutable(TableNode) table, SelectDelegate callback)
    {
        return cte(table, toSelect(callback));
    }

    typeof(this) uncte()
    {
        return with_(null);
    }
}
