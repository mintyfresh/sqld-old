
module sqld.ast.returning_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class ReturningNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _outputs;

public:
    this(immutable(ExpressionNode) output) immutable
    {
        this([output]);
    }

    this(immutable(ExpressionNode)[] outputs) immutable
    {
        this(new immutable ExpressionListNode(outputs));
    }

    this(immutable(ExpressionListNode) outputs) immutable
    {
        _outputs = outputs;
    }

    @property
    immutable(ExpressionListNode) outputs() immutable
    {
        return _outputs;
    }
}
