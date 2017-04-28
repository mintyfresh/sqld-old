
module sqld.ast.unary_node;

import sqld.ast.expression_node;

immutable abstract class UnaryNode(Operator : string) : ExpressionNode
{
private:
    Operator       _operator;
    ExpressionNode _operand;

public:
    this(Operator operator, immutable(ExpressionNode) operand)
    {
        _operator = operator;
        _operand  = operand;
    }

    @property
    Operator operator()
    {
        return _operator;
    }

    @property
    immutable(ExpressionNode) operand()
    {
        return _operand;
    }
}
