
module sqld.ast.ternary_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

class TernaryNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode _first;
    ExpressionNode _second;
    ExpressionNode _third;

public:
    this(const(ExpressionNode) first, const(ExpressionNode) second, const(ExpressionNode) third) const
    {
        _first  = first;
        _second = second;
        _third  = third;
    }

    @property
    const(ExpressionNode) first() const
    {
        return _first;
    }

    @property
    const(ExpressionNode) second() const
    {
        return _second;
    }

    @property
    const(ExpressionNode) third() const
    {
        return _third;
    }
}
