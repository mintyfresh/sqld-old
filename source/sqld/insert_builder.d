
module sqld.insert_builder;

import sqld.ast;
import sqld.builder;
import sqld.partials;
import sqld.select_builder;

import std.algorithm;
import std.array;
import std.meta;

struct InsertBuilder
{
    mixin Builder;
    mixin WithPartial;
    mixin ReturningPartial;

private:
    immutable
    {
        IntoNode   _into;
        ValuesNode _values;
        SelectNode _select;
    }

public:
    alias build this;

    @property
    immutable(InsertNode) build()
    {
        return new immutable InsertNode(_with_, _into, _values, _select, _returning);
    }

    /+ - Into - +/

    InsertBuilder into(immutable(IntoNode) into)
    {
        return next!("into")(into);
    }

    InsertBuilder into(immutable(TableNode) table, immutable(ColumnNode)[] columns...)
    {
        return into(new immutable IntoNode(table, columns));
    }
    
    InsertBuilder into(immutable(TableNode) table, string[] columns...)
    {
        return into(table, columns ? columns.map!(c => column(c)).array : null);
    }

    /+ - Values - +/

    InsertBuilder values(immutable(ValuesNode) values)
    {
        return next!("values")(values);
    }

    InsertBuilder values(immutable(ExpressionListNode) elements)
    {
        if(_values is null)
        {
            return values(new immutable ValuesNode(elements));
        }
        else
        {
            return values(new immutable ValuesNode(_values.values ~ elements));
        }
    }

    InsertBuilder values(immutable(ExpressionNode)[] elements...)
    {
        return values(new immutable ExpressionListNode(elements));
    }

    InsertBuilder values(TList...)(TList args) if(allSatisfy!(isExpressionType, TList))
    {
        return values(toExpressionList(args));
    }

    InsertBuilder revalues(TList...)(TList args)
    {
        return unvalues.values(args);
    }

    InsertBuilder unvalues()
    {
        return values(cast(ValuesNode) null);
    }

    /+ - Select - +/

    InsertBuilder select(immutable(SelectNode) select)
    {
        return next!("select")(select);
    }

    InsertBuilder select(SelectDelegate callback)
    {
        return select(toSelect(callback));
    }

    InsertBuilder unselect()
    {
        return select(cast(SelectNode) null);
    }
}
