
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
    this(string name) const
    {
        this(null, name);
    }

    this(const(TableNode) table, string name) const
    {
        _table = table;
        _name  = name;
    }

    @property
    const(TableNode) table() const
    {
        return _table;
    }

    @property
    string name() const
    {
        return _name;
    }
}
