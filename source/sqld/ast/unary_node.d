
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
    this(UnaryOperator operator, ExpressionNode operand)
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
    ExpressionNode operand()
    {
        return _operand;
    }
}

UnaryNode not(ExpressionNode operand)
{
    return new UnaryNode(UnaryOperator.not, operand);
}
