
module sqld.delete_builder;

import sqld.ast;
import sqld.builder;
import sqld.partials;
import sqld.select_builder;

struct DeleteBuilder
{
    mixin Builder;
    mixin FromPartial;
    mixin WherePartial;
    mixin LimitPartial;
    mixin ReturningPartial;

private:
    immutable(UsingNode) _using;

public:
    alias build this;

    @property
    immutable(DeleteNode) build()
    {
        return new immutable DeleteNode(_from, _using, _where, _limit, _returning);
    }

    /+ - Using - +/

    typeof(this) using(immutable(UsingNode) using)
    {
        return next!("using")(using);
    }

    typeof(this) using(immutable(ExpressionListNode) sources)
    {
        return using(new immutable UsingNode(sources));
    }

    typeof(this) using(immutable(ExpressionNode)[] sources...)
    {
        return using(new immutable ExpressionListNode(sources));
    }

    typeof(this) using(immutable(ExpressionNode) source, string name)
    {
        return using(source.as(name));
    }

    typeof(this) using(SelectDelegate callback, string name = "subquery")
    {
        return using(toSelect(callback).as(name));
    }

    typeof(this) unusing()
    {
        return using(cast(UsingNode) null);
    }
}
