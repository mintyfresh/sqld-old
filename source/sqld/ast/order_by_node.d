
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
    this(immutable(ExpressionNode) direction) immutable
    {
        this([direction]);
    }

    this(immutable(ExpressionNode)[] directions...) immutable
    {
        this(new immutable ExpressionListNode(directions));
    }

    this(immutable(ExpressionListNode) directions) immutable
    {
        _directions = directions;
    }

    @property
    immutable(ExpressionListNode) directions() immutable
    {
        return _directions;
    }
}
