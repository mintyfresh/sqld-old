
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
    this(ExpressionNode clause)
    {
        _clause = clause;
    }

    @property
    inout(ExpressionNode) clause() inout
    {
        return _clause;
    }
}
