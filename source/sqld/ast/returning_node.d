
module sqld.ast.returning_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class ReturningNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _outputs;

public:
    this(immutable(ExpressionNode) output)
    {
        this([output]);
    }

    this(immutable(ExpressionNode)[] outputs)
    {
        this(new immutable ExpressionListNode(outputs));
    }

    this(immutable(ExpressionListNode) outputs)
    {
        _outputs = outputs;
    }

    @property
    immutable(ExpressionListNode) outputs()
    {
        return _outputs;
    }
}
