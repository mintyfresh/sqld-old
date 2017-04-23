
module sqld.ast.column_node;

import sqld.ast.expression_node;
import sqld.ast.table_node;
import sqld.ast.visitor;

class ColumnNode : ExpressionNode
{
    mixin Visitable;

private:
    TableNode _table;
    string    _name;

public:
    this(string name) immutable
    {
        this(null, name);
    }

    this(immutable(TableNode) table, string name) immutable
    {
        _table = table;
        _name  = name;
    }

    @property
    immutable(TableNode) table() immutable
    {
        return _table;
    }

    @property
    string name() immutable
    {
        return _name;
    }
}
