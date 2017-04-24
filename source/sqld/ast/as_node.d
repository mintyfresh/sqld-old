
module sqld.ast.as_node;

import sqld.ast.binary_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;
import sqld.ast.table_node;

class AsNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode _node;
    string         _name;

public:
    this(immutable(ExpressionNode) node, string name) immutable
    {
        _node = node;
        _name = name;
    }

    @property
    immutable(ExpressionNode) node() immutable
    {
        return _node;
    }

    @property
    string name() immutable
    {
        return _name;
    }
}

immutable(AsNode) as(immutable(ExpressionNode) node, string name)
{
    return new immutable AsNode(node, name);
}

immutable(AsNode) as(immutable(ExpressionNode) node, immutable(TableNode) table)
{
    return as(node, table.name);
}
