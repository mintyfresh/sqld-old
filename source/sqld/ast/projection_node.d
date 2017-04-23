
module sqld.ast.projection_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class ProjectionNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _projections;

public:
    this(immutable(ExpressionNode) projection) immutable
    {
        this(new immutable ExpressionListNode([projection]));
    }

    this(immutable(ExpressionListNode) projections) immutable
    {
        _projections = projections;
    }

    @property
    immutable(ExpressionListNode) projections() immutable
    {
        return _projections;
    }
}
