
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
    this(const(ExpressionNode) projection) const
    {
        this(new const ExpressionListNode([projection]));
    }

    this(const(ExpressionListNode) projections) const
    {
        _projections = projections;
    }

    @property
    const(ExpressionListNode) projections() const
    {
        return _projections;
    }
}
