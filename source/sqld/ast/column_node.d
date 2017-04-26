
module sqld.ast.column_node;

import sqld.ast.expression_node;
import sqld.ast.table_node;
import sqld.ast.visitor;

immutable class ColumnNode : ExpressionNode
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

    this(immutable(TableNode) table, string name)
    {
        _table = table;
        _name  = name;
    }

    @property
    immutable(TableNode) table()
    {
        return _table;
    }

    @property
    string name()
    {
        return _name;
    }
}
