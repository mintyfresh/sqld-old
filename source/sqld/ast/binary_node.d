
module sqld.ast.binary_node;

import sqld.ast.expression_node;

class BinaryNode : ExpressionNode
{
private:
    ExpressionNode _left;
    string         _operator;
    ExpressionNode _right;

public:
    this(ExpressionNode left, string operator, ExpressionNode right)
    {
        _left     = left;
        _operator = operator;
        _right    = right;
    }

    @property
    ExpressionNode left()
    {
        return _left;
    }

    @property
    string operator()
    {
        return _operator;
    }

    @property
    ExpressionNode right()
    {
        return _right;
    }
}
