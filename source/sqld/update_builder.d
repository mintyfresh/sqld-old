
module sqld.update_builder;

import sqld.ast;
import sqld.builder;
import sqld.partials;

struct UpdateBuilder
{
    mixin Builder;
    mixin FromPartial;
    mixin WherePartial;
    mixin LimitPartial;
    mixin ReturningPartial;

private:
    immutable
    {
        TableNode     _table;
        SetNode       _set;
    }

public:
    alias build this;

    @property
    immutable(UpdateNode) build()
    {
        return new immutable UpdateNode(_table, _set, _from, _where, _limit, _returning);
    }

    /+ - Table - +/

    UpdateBuilder update(immutable(TableNode) table)
    {
        return next!("table")(table);
    }

    UpdateBuilder update(string name)
    {
        return update(TableNode(name));
    }

    /+ - Set - +/

    UpdateBuilder set(immutable(SetNode) set)
    {
        return next!("set")(set);
    }

    UpdateBuilder set(immutable(AssignmentNode) assignment)
    {
        if(_set is null)
        {
            return set(new immutable SetNode(assignment));
        }
        else
        {
            return set(new immutable SetNode(_set.assignments ~ assignment));
        }
    }

    UpdateBuilder set(T)(immutable(ExpressionNode) left, T right) if(isExpressionType!(T))
    {
        return set(new immutable AssignmentNode(left, expression(right)));
    }

    UpdateBuilder set(T)(string left, T right) if(isExpressionType!(T))
    {
        return set(new immutable ColumnNode(left), right);
    }

    UpdateBuilder reset(TList...)(TList args)
    {
        return unset.set(args);
    }

    UpdateBuilder unset()
    {
        return set(cast(SetNode) null);
    }
}
