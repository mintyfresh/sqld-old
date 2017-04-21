
module sqld.ast.projection_node;

import sqld.ast.expression_node;
import sqld.ast.node;

class ProjectionNode : Node
{
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
