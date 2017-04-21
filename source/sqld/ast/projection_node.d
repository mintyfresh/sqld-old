
module sqld.ast.projection_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class ProjectionNode : Node
{
    mixin Visitable;

private:
    ExpressionNode _projection;

public:
    this(ExpressionNode projection)
    {
        _projection = projection;
    }

    @property
    ExpressionNode projection()
    {
        return _projection;
    }
}
