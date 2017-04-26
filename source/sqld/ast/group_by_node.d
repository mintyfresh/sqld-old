
module sqld.ast.group_by_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class GroupByNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _groupings;

public:
    this(immutable(ExpressionNode) grouping)
    {
        this([grouping]);
    }

    this(immutable(ExpressionNode)[] groupings...)
    {
        this(new immutable ExpressionListNode(groupings));
    }

    this(immutable(ExpressionListNode) groupings)
    {
        _groupings = groupings;
    }

    @property
    immutable(ExpressionListNode) groupings()
    {
        return _groupings;
    }
}
