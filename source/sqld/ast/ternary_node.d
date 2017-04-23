
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
    this(immutable(ExpressionNode) first, immutable(ExpressionNode) second, immutable(ExpressionNode) third) immutable
    {
        _first  = first;
        _second = second;
        _third  = third;
    }

    @property
    immutable(ExpressionNode) first() immutable
    {
        return _first;
    }

    @property
    immutable(ExpressionNode) second() immutable
    {
        return _second;
    }

    @property
    immutable(ExpressionNode) third() immutable
    {
        return _third;
    }
}
