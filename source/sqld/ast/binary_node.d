
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
    isNotDistinctFrom = "IS NOT DISTINCT FROM",
    plus              = "+",
    minus             = "-",
    times             = "*",
    divide            = "/",
    modulo            = "%",
    bitAnd            = "&",
    bitOr             = "|",
    bitXor            = "^",
    shiftLeft         = "<<",
    shiftRight        = ">>"
}

immutable class BinaryNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode _left;
    BinaryOperator _operator;
    ExpressionNode _right;

public:
    this(immutable(ExpressionNode) left, BinaryOperator operator, immutable(ExpressionNode) right)
    {
        _left     = left;
        _operator = operator;
        _right    = right;
    }

    @property
    immutable(ExpressionNode) left()
    {
        return _left;
    }

    @property
    BinaryOperator operator()
    {
        return _operator;
    }

    @property
    immutable(ExpressionNode) right()
    {
        return _right;
    }
}

immutable(BinaryNode) and(immutable(ExpressionNode) left, immutable(ExpressionNode) right)
{
    return new immutable BinaryNode(left, BinaryOperator.and, right);
}

immutable(BinaryNode) or(immutable(ExpressionNode) left, immutable(ExpressionNode) right)
{
    return new immutable BinaryNode(left, BinaryOperator.or, right);
}

immutable(BinaryNode) eq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable BinaryNode(toExpression(left), BinaryOperator.equal, toExpression(right));
}

immutable(BinaryNode) notEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable BinaryNode(toExpression(left), BinaryOperator.equal, toExpression(right));
}

immutable(BinaryNode) lt(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable BinaryNode(toExpression(left), BinaryOperator.lessThan, toExpression(right));
}

immutable(BinaryNode) ltEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable BinaryNode(toExpression(left), BinaryOperator.lessOrEqual, toExpression(right));
}

immutable(BinaryNode) gt(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable BinaryNode(toExpression(left), BinaryOperator.greaterThan, toExpression(right));
}

immutable(BinaryNode) gtEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable BinaryNode(toExpression(left), BinaryOperator.greaterOrEqual, toExpression(right));
}
