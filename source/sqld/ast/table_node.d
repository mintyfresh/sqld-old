
module sqld.ast.table_node;

import sqld.ast.column_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

immutable class TableNode : ExpressionNode
{
    mixin Visitable;

private:
    string _schema;
    string _name;

public:
    this(string name)
    {
        this(null, name);
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

    immutable(ColumnNode) opIndex(string name)
    {
        return new immutable ColumnNode(this, name);
    }
}

immutable(TableNode) table(string name)
{
    return new immutable TableNode(name);
}

immutable(TableNode) table(string schema, string name)
{
    return new immutable TableNode(schema, name);
}
