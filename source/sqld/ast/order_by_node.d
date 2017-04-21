
module sqld.ast.order_by_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class OrderByNode : Node
{
    mixin Visitable;

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
