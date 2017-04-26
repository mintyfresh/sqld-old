
module sqld.ast.projection_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class ProjectionNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _projections;

public:
    this(immutable(ExpressionNode) projection)
    {
        this(new immutable ExpressionListNode([projection]));
    }

    this(immutable(ExpressionListNode) projections)
    {
        _projections = projections;
    }

    @property
    immutable(ExpressionListNode) projections()
    {
        return _projections;
    }
}
