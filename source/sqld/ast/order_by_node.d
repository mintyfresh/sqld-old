
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
    this(ExpressionNode directions)
    {
        _directions = new ExpressionListNode([directions]);
    }

    this(ExpressionListNode directions)
    {
        _directions = directions;
    }

    @property
    inout(ExpressionListNode) directions() inout
    {
        return _directions;
    }
}
