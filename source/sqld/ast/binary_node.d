
module sqld.ast.binary_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

enum BinaryOperator : string
{
    and               = "AND",
    or                = "OR",
    equal             = "=",
    notEqual          = "!=",
    lessThan          = "<",
    lessOrEqual       = "<=",
    greaterThan       = ">",
    greaterOrEqual    = ">=",
    in_               = "IN",
    notIn             = "NOT IN",
    isDistinctFrom    = "IS DISTINCT FROM",
    isNotDistinctFrom = "IS NOT DISTINCT FROM"
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
    inout(ExpressionNode) left() inout
    {
        return _left;
    }

    @property
    BinaryOperator operator() inout
    {
        return _operator;
    }

    @property
    inout(ExpressionNode) right() inout
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

BinaryNode eq(ExpressionNode left, ExpressionNode right)
{
    return new BinaryNode(left, BinaryOperator.equal, right);
}

BinaryNode notEq(ExpressionNode left, ExpressionNode right)
{
    return new BinaryNode(left, BinaryOperator.equal, right);
}
