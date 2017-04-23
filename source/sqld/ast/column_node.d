
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
        _name = name;
    }

    this(TableNode table, string name)
    {
        _table = table;
        _name  = name;
    }

    @property
    TableNode table()
    {
        return _table;
    }

    @property
    string name()
    {
        return _name;
    }
}
