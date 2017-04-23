
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
    this(ExpressionNode groupings)
    {
        _groupings = new ExpressionListNode([groupings]);
    }

    this(ExpressionListNode groupings)
    {
        _groupings = groupings;
    }

    @property
    ExpressionListNode groupings()
    {
        return _groupings;
    }
}
