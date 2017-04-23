
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
    this(string name)
    {
        this(null, name);
    }

    this(TableNode table, string name)
    {
        _table = table;
        _name  = name;
    }

    this(inout(TableNode) table, string name) inout
    {
        _table = table;
        _name  = name;
    }

    @property
    inout(TableNode) table() inout
    {
        return _table;
    }

    @property
    string name() inout
    {
        return _name;
    }
}
