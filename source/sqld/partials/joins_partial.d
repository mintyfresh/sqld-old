
module sqld.partials.joins_partial;

mixin template JoinsPartial()
{
    import sqld.ast;
    import sqld.select_builder;

    import std.meta : Alias;

private:
    immutable(JoinNode)[] _joins;

public:
    struct JoinBuilder
    {
        alias BuilderType = Alias!(__traits(parent, typeof(this)));

    private:
        BuilderType               _builder;
        JoinType                  _joinType;
        immutable(ExpressionNode) _source;

    public:
        alias build this;

        this(BuilderType builder, JoinType joinType, immutable(ExpressionNode) source)
        {
            _builder  = builder;
            _joinType = joinType;
            _source   = source;
        }

        BuilderType build()
        {
            return _builder.join(_joinType, _source);
        }

        BuilderType on(immutable(ExpressionNode) condition)
        {
            return _builder.join(_joinType, _source, condition);
        }
    }

    typeof(this) joins(immutable(JoinNode)[] joins)
    {
        return next!("joins")(joins);
    }

    typeof(this) join(immutable(JoinNode) join)
    {
        return joins(_joins ~ join);
    }

    typeof(this) join(JoinType joinType, SelectDelegate callback, immutable(ExpressionNode) condition)
    {
        return join(new immutable JoinNode(joinType, toSelect(callback), condition));
    }

    typeof(this) join(JoinType joinType, immutable(ExpressionNode) source, immutable(ExpressionNode) condition)
    {
        return join(new immutable JoinNode(joinType, source, condition));
    }

    JoinBuilder join(JoinType joinType, SelectDelegate callback)
    {
        return JoinBuilder(this, joinType, toSelect(callback));
    }

    JoinBuilder join(JoinType joinType, immutable(ExpressionNode) source)
    {
        return JoinBuilder(this, joinType, source);
    }

    typeof(this) join(SelectDelegate callback, immutable(ExpressionNode) condition)
    {
        return join(JoinType.inner, toSelect(callback), condition);
    }

    typeof(this) join(immutable(ExpressionNode) source, immutable(ExpressionNode) condition)
    {
        return join(JoinType.inner, source, condition);
    }

    JoinBuilder join(SelectDelegate callback)
    {
        return JoinBuilder(this, JoinType.inner, toSelect(callback));
    }

    JoinBuilder join(immutable(ExpressionNode) source)
    {
        return JoinBuilder(this, JoinType.inner, source);
    }

    auto rejoin(TList...)(TList args)
    {
        return unjoin.join(args);
    }

    typeof(this) unjoin()
    {
        return joins([]);
    }
}
