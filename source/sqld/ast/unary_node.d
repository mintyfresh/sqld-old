
module sqld.ast.unary_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

enum UnaryOperator : string
{
    not = "NOT"
}

immutable class UnaryNode : ExpressionNode
{
    mixin Visitable;

private:
    UnaryOperator  _operator;
    ExpressionNode _operand;

public:
    this(UnaryOperator operator, immutable(ExpressionNode) operand)
    {
        _operator = operator;
        _operand  = operand;
    }

    @property
    UnaryOperator operator()
    {
        return _operator;
    }

    @property
    immutable(ExpressionNode) operand()
    {
        return _operand;
    }
}

immutable(UnaryNode) not(immutable(ExpressionNode) operand)
{
    return new immutable UnaryNode(UnaryOperator.not, operand);
}
