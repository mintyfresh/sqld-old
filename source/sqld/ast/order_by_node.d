
module sqld.ast.group_by_node;

import sqld.ast.expression_node;
import sqld.ast.node;

class OrderByNode : Node
{
private:
    ExpressionNode _directions;

public:
    this(ExpressionNode directions)
    {
        _directions = directions;
    }

    @property
    ExpressionNode directions()
    {
        return _directions;
    }
}
