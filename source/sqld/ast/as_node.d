
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
    this(ExpressionNode node, string name)
    {
        _node = node;
        _name = name;
    }

    @property
    inout(ExpressionNode) node() inout
    {
        return _node;
    }

    @property
    string name() inout
    {
        return _name;
    }
}
