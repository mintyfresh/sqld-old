
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
    this(const(ExpressionNode) node, string name) const
    {
        _node = node;
        _name = name;
    }

    @property
    const(ExpressionNode) node() const
    {
        return _node;
    }

    @property
    string name() const
    {
        return _name;
    }
}
