
module sqld.ast.insert_node;

import sqld.ast.into_node;
import sqld.ast.query_node;
import sqld.ast.returning_node;
import sqld.ast.select_node;
import sqld.ast.values_node;
import sqld.ast.visitor;
import sqld.ast.with_node;

import std.meta;

class InsertNode : QueryNode
{
    mixin Visitable;

private:
    WithNode      _with_;
    IntoNode      _into;
    ValuesNode    _values;
    SelectNode    _select;
    ReturningNode _returning;

public:
    this(immutable(WithNode) with_, immutable(IntoNode) into, immutable(ValuesNode) values,
         immutable(SelectNode) select, immutable(ReturningNode) returning) immutable
    {
        foreach(name; AliasSeq!("with_", "into", "values", "select", "returning"))
        {
            mixin("_" ~ name ~ " = " ~ name ~ ";");
        }
    }

    @property
    immutable(IntoNode) into() immutable
    {
        return _into;
    }

    @property
    immutable(ValuesNode) values() immutable
    {
        return _values;
    }

    @property
    immutable(SelectNode) select() immutable
    {
        return _select;
    }

    @property
    immutable(ReturningNode) returning() immutable
    {
        return _returning;
    }
}
