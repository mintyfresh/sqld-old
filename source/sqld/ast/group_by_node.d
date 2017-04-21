
module sqld.ast.group_by_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class GroupByNode : Node
{
    mixin Visitable;

private:
    ExpressionNode _groupings;

public:
    this(ExpressionNode groupings)
    {
        _groupings = groupings;
    }

    @property
    ExpressionNode groupings()
    {
        return _groupings;
    }
}
