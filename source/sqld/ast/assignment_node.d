
module sqld.ast.assignment_node;

import sqld.ast.binary_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

immutable class AssignmentNode : BinaryNode
{
    mixin Visitable;

public:
    this(immutable(ExpressionNode) left, immutable(ExpressionNode) right)
    {
        super(left, right);
    }
}
