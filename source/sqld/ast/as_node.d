
module sqld.ast.as_node;

import sqld.ast.binary_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

class AsNode : BinaryNode
{
    mixin Visitable;

    this(ExpressionNode left, ExpressionNode right)
    {
        super(left, "AS", right);
    }
}
