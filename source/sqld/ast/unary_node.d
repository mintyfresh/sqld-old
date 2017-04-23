
module sqld.ast.unary_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

enum UnaryOperator : string
{
    not = "NOT"
}

class UnaryNode : ExpressionNode
{
    mixin Visitable;

private:
    UnaryOperator  _operator;
    ExpressionNode _operand;

public:
    this(UnaryOperator operator, immutable(ExpressionNode) operand) immutable
    {
        _operator = operator;
        _operand  = operand;
    }

    @property
    UnaryOperator operator() immutable
    {
        return _operator;
    }

    @property
    immutable(ExpressionNode) operand() immutable
    {
        return _operand;
    }
}

immutable(UnaryNode) not(immutable(ExpressionNode) operand)
{
    return new immutable UnaryNode(UnaryOperator.not, operand);
}
