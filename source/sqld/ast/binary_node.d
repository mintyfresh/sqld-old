
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
    this(const(ExpressionNode) left, BinaryOperator operator, const(ExpressionNode) right) const
    {
        _left     = left;
        _operator = operator;
        _right    = right;
    }

    @property
    const(ExpressionNode) left() const
    {
        return _left;
    }

    @property
    BinaryOperator operator() const
    {
        return _operator;
    }

    @property
    const(ExpressionNode) right() const
    {
        return _right;
    }
}

const(BinaryNode) and(const(ExpressionNode) left, const(ExpressionNode) right)
{
    return new const BinaryNode(left, BinaryOperator.and, right);
}

const(BinaryNode) or(const(ExpressionNode) left, const(ExpressionNode) right)
{
    return new const BinaryNode(left, BinaryOperator.or, right);
}

const(BinaryNode) eq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new const BinaryNode(expression(left), BinaryOperator.equal, expression(right));
}

const(BinaryNode) notEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new const BinaryNode(expression(left), BinaryOperator.equal, expression(right));
}
