
module sqld.ast.where_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class WhereNode : Node
{
    mixin Visitable;

private:
    ExpressionNode _clause;

public:
    this(immutable(ExpressionNode) clause)
    {
        _clause = clause;
    }

    @property
    immutable(ExpressionNode) clause()
    {
        return _clause;
    }
}
