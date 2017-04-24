
module sqld.ast.group_by_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class GroupByNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _groupings;

public:
    this(immutable(ExpressionNode) grouping) immutable
    {
        this([grouping]);
    }

    this(immutable(ExpressionNode)[] groupings...) immutable
    {
        this(new immutable ExpressionListNode(groupings));
    }

    this(immutable(ExpressionListNode) groupings) immutable
    {
        _groupings = groupings;
    }

    @property
    immutable(ExpressionListNode) groupings() immutable
    {
        return _groupings;
    }
}
