
module sqld.ast.table_node;

import sqld.ast.column_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

class TableNode : ExpressionNode
{
    mixin Visitable;

private:
    string _schema;
    string _name;

public:
    this(string name) const
    {
        _name = name;
    }

    this(string schema, string name) const
    {
        _schema = schema;
        _name   = name;
    }

    @property
    string schema() const
    {
        return _schema;
    }

    @property
    string name() const
    {
        return _name;
    }

    const(ColumnNode) opIndex(string name) const
    {
        return new const ColumnNode(this, name);
    }
}
