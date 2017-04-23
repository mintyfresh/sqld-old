
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
    this(string name) immutable
    {
        _name = name;
    }

    this(string schema, string name) immutable
    {
        _schema = schema;
        _name   = name;
    }

    static immutable(TableNode) opCall(string name)
    {
        return new immutable TableNode(name);
    }

    @property
    string schema() immutable
    {
        return _schema;
    }

    @property
    string name() immutable
    {
        return _name;
    }

    immutable(ColumnNode) opIndex(string name) immutable
    {
        return new immutable ColumnNode(this, name);
    }
}
