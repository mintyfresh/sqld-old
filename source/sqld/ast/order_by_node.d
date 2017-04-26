
module sqld.ast.order_by_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class OrderByNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _directions;

public:
    this(immutable(ExpressionNode) direction)
    {
        this([direction]);
    }

    this(immutable(ExpressionNode)[] directions...)
    {
        this(new immutable ExpressionListNode(directions));
    }

    this(immutable(ExpressionListNode) directions)
    {
        _directions = directions;
    }

    @property
    immutable(ExpressionListNode) directions()
    {
        return _directions;
    }
}
