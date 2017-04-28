
module sqld.ast.prefix_node;

import sqld.ast.expression_node;
import sqld.ast.unary_node;
import sqld.ast.visitor;

enum PrefixOperator : string
{
    not = "NOT"
}

immutable class PrefixNode : UnaryNode!(PrefixOperator)
{
    mixin Visitable;

    this(PrefixOperator operator, immutable(ExpressionNode) operand)
    {
        super(operator, operand);
    }
}

immutable(PrefixNode) not(immutable(ExpressionNode) operand)
{
    return new immutable PrefixNode(PrefixOperator.not, operand);
}
