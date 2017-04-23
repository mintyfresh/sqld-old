
module sqld.ast.where_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class WhereNode : Node
{
    mixin Visitable;

private:
    ExpressionNode _clause;

public:
    this(const(ExpressionNode) clause) const
    {
        _clause = clause;
    }

    @property
    const(ExpressionNode) clause() const
    {
        return _clause;
    }
}
