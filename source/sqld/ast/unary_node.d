
module sqld.ast.unary_node;

import sqld.ast.expression_node;

immutable abstract class UnaryNode : ExpressionNode
{
private:
    ExpressionNode _operand;

public:
    this(immutable(ExpressionNode) operand)
    {
        _operand  = operand;
    }

    @property
    immutable(ExpressionNode) operand()
    {
        return _operand;
    }
}
