
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
    this(const(ExpressionNode) groupings) const
    {
        _groupings = new const ExpressionListNode([groupings]);
    }

    this(const(ExpressionListNode) groupings) const
    {
        _groupings = groupings;
    }

    @property
    const(ExpressionListNode) groupings() const
    {
        return _groupings;
    }
}
