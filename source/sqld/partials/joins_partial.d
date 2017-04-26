
module sqld.partials.joins_partial;

mixin template JoinsPartial()
{
    import sqld.ast;
    import std.meta;

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

    typeof(this) join(JoinType joinType, typeof(this) delegate(typeof(this)) callback,
                       immutable(ExpressionNode) condition)
    {
        return join(new immutable JoinNode(joinType, callback(typeof(this).init).build, condition));
    }

    typeof(this) join(JoinType joinType, immutable(ExpressionNode) source, immutable(ExpressionNode) condition)
    {
        return join(new immutable JoinNode(joinType, source, condition));
    }

    JoinBuilder join(JoinType joinType, typeof(this) delegate(typeof(this)) callback)
    {
        return JoinBuilder(this, joinType, callback(typeof(this).init).build);
    }

    JoinBuilder join(JoinType joinType, immutable(ExpressionNode) source)
    {
        return JoinBuilder(this, joinType, source);
    }

    typeof(this) join(typeof(this) delegate(typeof(this)) callback, immutable(ExpressionNode) condition)
    {
        return join(JoinType.inner, callback(typeof(this).init).build, condition);
    }

    typeof(this) join(immutable(ExpressionNode) source, immutable(ExpressionNode) condition)
    {
        return join(JoinType.inner, source, condition);
    }

    JoinBuilder join(typeof(this) delegate(typeof(this)) callback)
    {
        return JoinBuilder(this, JoinType.inner, callback(typeof(this).init).build);
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
