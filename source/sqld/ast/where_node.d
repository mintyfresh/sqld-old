
module sqld.ast.where_node;

import sqld.ast.expression_node;
import sqld.ast.node;

class WhereNode : Node
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
