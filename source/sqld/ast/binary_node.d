
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
    this(immutable(ExpressionNode) left, BinaryOperator operator, immutable(ExpressionNode) right) immutable
    {
        _left     = left;
        _operator = operator;
        _right    = right;
    }

    @property
    immutable(ExpressionNode) left() immutable
    {
        return _left;
    }

    @property
    BinaryOperator operator() immutable
    {
        return _operator;
    }

    @property
    immutable(ExpressionNode) right() immutable
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
    return new immutable BinaryNode(expression(left), BinaryOperator.equal, expression(right));
}

immutable(BinaryNode) notEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable BinaryNode(expression(left), BinaryOperator.equal, expression(right));
}
