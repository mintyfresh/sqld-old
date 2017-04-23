
module sqld.ast.binary_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

enum BinaryOperator : string
{
    and = "AND",
    or  = "OR"
}

class BinaryNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode _left;
    BinaryOperator _operator;
    ExpressionNode _right;

public:
    this(ExpressionNode left, BinaryOperator operator, ExpressionNode right)
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
    BinaryOperator operator()
    {
        return _operator;
    }

    @property
    ExpressionNode right()
    {
        return _right;
    }
}

BinaryNode and(ExpressionNode left, ExpressionNode right)
{
    return new BinaryNode(left, BinaryOperator.and, right);
}

BinaryNode or(ExpressionNode left, ExpressionNode right)
{
    return new BinaryNode(left, BinaryOperator.or, right);
}
