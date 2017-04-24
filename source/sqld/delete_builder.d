
module sqld.delete_builder;

import sqld.ast;
import sqld.builder;
import sqld.partials;

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

    typeof(this) using(immutable(ExpressionNode)[] sources...)
    {
        if(_using is null)
        {
            return using(new immutable UsingNode(sources));
        }
        else
        {
            return using(new immutable UsingNode(_using.sources ~ sources));
        }
    }

    typeof(this) using(immutable(ExpressionNode) source, string name)
    {
        return using(source.as(name));
    }

    typeof(this) reusing(TList...)(TList args)
    {
        return unusing.using(args);
    }

    typeof(this) unusing()
    {
        return using(cast(UsingNode) null);
    }
}
