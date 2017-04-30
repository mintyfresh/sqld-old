
module sqld.ast.binary_node;

import sqld.ast.expression_node;

immutable abstract class BinaryNode : ExpressionNode
{
private:
    ExpressionNode _left;
    ExpressionNode _right;

public:
    this(immutable(ExpressionNode) left, immutable(ExpressionNode) right)
    {
        _left  = left;
        _right = right;
    }

    @property
    immutable(ExpressionNode) left()
    {
        return _left;
    }

    @property
    immutable(ExpressionNode) right()
    {
        return _right;
    }
}
