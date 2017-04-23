
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
    this(ExpressionNode first, ExpressionNode second, ExpressionNode third)
    {
        _first  = first;
        _second = second;
        _third  = third;
    }

    @property
    inout(ExpressionNode) first() inout
    {
        return _first;
    }

    @property
    inout(ExpressionNode) second() inout
    {
        return _second;
    }

    @property
    inout(ExpressionNode) third() inout
    {
        return _third;
    }
}
