
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
    this(string name)
    {
        _name = name;
    }

    this(string schema, string name)
    {
        _schema = schema;
        _name   = name;
    }

    @property
    string schema()
    {
        return _schema;
    }

    @property
    string name()
    {
        return _name;
    }

    ColumnNode opIndex(string name)
    {
        return new ColumnNode(this, name);
    }
}
