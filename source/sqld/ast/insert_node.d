
module sqld.ast.insert_node;

import sqld.ast.into_node;
import sqld.ast.query_node;
import sqld.ast.returning_node;
import sqld.ast.select_node;
import sqld.ast.values_node;
import sqld.ast.visitor;

class InsertNode : QueryNode
{
private:
    IntoNode      _into;
    ValuesNode    _values;
    SelectNode    _select;
    ReturningNode _returning;

public:
    this(immutable(IntoNode) into, immutable(ValuesNode) values, immutable(SelectNode) select,
         immutable(ReturningNode) returning) immutable
    {
        _into      = into;
        _values    = values;
        _select    = select;
        _returning = returning;
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
