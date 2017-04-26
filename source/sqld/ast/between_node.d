
module sqld.ast.between_node;

import sqld.ast.expression_node;
import sqld.ast.ternary_node;
import sqld.ast.visitor;

immutable class BetweenNode : TernaryNode
{
    mixin Visitable;

    this(immutable(ExpressionNode) first, immutable(ExpressionNode) second, immutable(ExpressionNode) third)
    {
        super(first, second, third);
    }
}
