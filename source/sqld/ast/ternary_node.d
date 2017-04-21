
module sqld.ast.ternary_node;

import sqld.ast.expression_node;

class TernaryNode : ExpressionNode
{
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
    ExpressionNode first()
    {
        return _first;
    }

    @property
    ExpressionNode second()
    {
        return _second;
    }

    @property
    ExpressionNode third()
    {
        return _third;
    }
}
