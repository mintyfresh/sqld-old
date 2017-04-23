
module sqld.ast.as_node;

import sqld.ast.binary_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

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
