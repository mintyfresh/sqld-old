
module sqld.update_builder;

import sqld.ast;

struct UpdateBuilder
{
private:
    immutable
    {
        TableNode     _table;
        SetNode       _set;
        FromNode      _from;
        WhereNode     _where;
        ReturningNode _returning;
    }

public:
    @property
    immutable(UpdateNode) build()
    {
        return new immutable UpdateNode(_table, _set, _from, _where, _returning);
    }

    /+ - Table - +/

    UpdateBuilder table(immutable(TableNode) table)
    {
        return UpdateBuilder(table, _set, _from, _where, _returning);
    }

    UpdateBuilder table(string name)
    {
        return table(TableNode(name));
    }

    /+ - Set - +/

    UpdateBuilder set(immutable(SetNode) set)
    {
        return UpdateBuilder(_table, set, _from, _where, _returning);
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

    /+ - From - +/

    UpdateBuilder from(immutable(FromNode) from)
    {
        return UpdateBuilder(_table, _set, from, _where, _returning);
    }

    UpdateBuilder from(immutable(ExpressionNode) source, string name = null)
    {
        auto value = name ? new immutable AsNode(source, name) : source;

        if(_from is null)
        {
            return from(new immutable FromNode(value));
        }
        else
        {
            return from(new immutable FromNode(_from.sources ~ value));
        }
    }

    UpdateBuilder refrom(immutable(ExpressionNode) node, string name = null)
    {
        return unfrom.from(node, name);
    }

    UpdateBuilder unfrom()
    {
        return from(cast(FromNode) null);
    }

    /+ - Where - +/

    UpdateBuilder where(immutable(WhereNode) where)
    {
        return UpdateBuilder(_table, _set, _from, where, _returning);
    }

    UpdateBuilder where(immutable(ExpressionNode) condition)
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

    UpdateBuilder rewhere(immutable(ExpressionNode) condition)
    {
        return unwhere.where(condition);
    }

    UpdateBuilder unwhere()
    {
        return where(cast(WhereNode) null);
    }

    /+ - Returning - +/

    UpdateBuilder returning(immutable(ReturningNode) returning)
    {
        return UpdateBuilder(_table, _set, _from, _where, returning);
    }

    UpdateBuilder returning(immutable(ExpressionNode) outputs)
    {
        if(_returning is null)
        {
            return returning(new immutable ReturningNode(outputs));
        }
        else
        {
            return returning(new immutable ReturningNode(_returning.outputs ~ outputs));
        }
    }

    UpdateBuilder rereturning(immutable(ExpressionNode) outputs)
    {
        return unreturning.returning(outputs);
    }

    UpdateBuilder unreturning()
    {
        return returning(cast(ReturningNode) null);
    }
}
