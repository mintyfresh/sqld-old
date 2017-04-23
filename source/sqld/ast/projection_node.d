
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
    this(ExpressionNode projection)
    {
        this(new ExpressionListNode([projection]));
    }

    this(ExpressionListNode projections)
    {
        _projections = projections;
    }

    @property
    inout(ExpressionListNode) projections() inout
    {
        return _projections;
    }
}
