
module sqld.ast.binary_node;

import sqld.ast.expression_node;

class BinaryNode : ExpressionNode
{
private:
    ExpressionNode _left;
    ExpressionNode _right;

public:
    @property
    ExpressionNode left()
    {
        return _left;
    }

    @property
    ExpressionNode right()
    {
        return _right;
    }
}
