
module sqld.partials.where_partial;

mixin template WherePartial()
{
    import sqld.ast;

private:
    immutable(WhereNode) _where;

public:
    typeof(this) where(immutable(WhereNode) where)
    {
        return next!("where")(where);
    }

    typeof(this) where(immutable(ExpressionNode) condition)
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

    typeof(this) rewhere(immutable(ExpressionNode) condition)
    {
        return unwhere.where(condition);
    }

    typeof(this) unwhere()
    {
        return where(cast(WhereNode) null);
    }
}
