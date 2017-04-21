
module sqld.ast.group_by_node;

import sqld.ast.expression_node;
import sqld.ast.node;

class GroupByNode : Node
{
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
