
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
    this(immutable(ExpressionNode) clause) immutable
    {
        _clause = clause;
    }

    @property
    immutable(ExpressionNode) clause() immutable
    {
        return _clause;
    }
}
