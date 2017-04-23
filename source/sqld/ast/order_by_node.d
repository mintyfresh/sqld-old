
module sqld.ast.order_by_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class OrderByNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _directions;

public:
    this(const(ExpressionNode) directions) const
    {
        _directions = new const ExpressionListNode([directions]);
    }

    this(const(ExpressionListNode) directions) const
    {
        _directions = directions;
    }

    @property
    const(ExpressionListNode) directions() const
    {
        return _directions;
    }
}
