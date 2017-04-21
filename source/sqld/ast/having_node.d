
module sqld.ast.having_node;

import sqld.ast.expression_node;
import sqld.ast.node;

class HavingNode : Node
{
private:
    ExpressionNode _clause;

public:
    this(ExpressionNode clause)
    {
        _clause = clause;
    }

    @property
    ExpressionNode clause()
    {
        return _clause;
    }
}
