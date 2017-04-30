
module sqld.ast.prefix_node;

import sqld.ast.expression_node;
import sqld.ast.unary_node;
import sqld.ast.visitor;

enum PrefixOperator : string
{
    not = "NOT"
}

immutable class PrefixNode : UnaryNode
{
    mixin Visitable;

private:
    PrefixOperator _operator;

public:
    this(PrefixOperator operator, immutable(ExpressionNode) operand)
    {
        super(operand);
        _operator = operator;
    }

    @property
    PrefixOperator operator()
    {
        return _operator;
    }
}

immutable(PrefixNode) not(immutable(ExpressionNode) operand)
{
    return new immutable PrefixNode(PrefixOperator.not, operand);
}
