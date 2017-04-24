
module sqld.partials.limit_partial;

mixin template LimitPartial()
{
    import sqld.ast;

private:
    immutable(LimitNode) _limit;

public:
    typeof(this) limit(immutable(LimitNode) limit)
    {
        return next!("limit")(limit);
    }

    typeof(this) limit(ulong value)
    {
        return limit(new immutable LimitNode(value));
    }

    typeof(this) unlimit()
    {
        return limit(null);
    }
}
