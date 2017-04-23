
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
    this(UnaryOperator operator, const(ExpressionNode) operand) const
    {
        _operator = operator;
        _operand  = operand;
    }

    @property
    UnaryOperator operator() const
    {
        return _operator;
    }

    @property
    const(ExpressionNode) operand() const
    {
        return _operand;
    }
}

const(UnaryNode) not(const(ExpressionNode) operand)
{
    return new const UnaryNode(UnaryOperator.not, operand);
}
