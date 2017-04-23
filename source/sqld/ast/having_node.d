
module sqld.ast.having_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class HavingNode : Node
{
    mixin Visitable;

private:
    ExpressionNode _clause;

public:
    this(const(ExpressionNode) clause) const
    {
        _clause = clause;
    }

    @property
    const(ExpressionNode) clause() const
    {
        return _clause;
    }
}
