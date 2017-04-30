
module sqld.ast.relational_node;

import sqld.ast.binary_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

enum RelationalOperator : string
{
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

immutable class RelationalNode : BinaryNode
{
    mixin Visitable;

private:
    RelationalOperator _operator;

public:
    this(immutable(ExpressionNode) left, RelationalOperator operator, immutable(ExpressionNode) right)
    {
        super(left, right);
        _operator = operator;
    }

    @property
    RelationalOperator operator()
    {
        return _operator;
    }
}

immutable(RelationalNode) eq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable RelationalNode(toExpression(left), RelationalOperator.equal, toExpression(right));
}

immutable(RelationalNode) notEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable RelationalNode(toExpression(left), RelationalOperator.equal, toExpression(right));
}

immutable(RelationalNode) lt(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable RelationalNode(toExpression(left), RelationalOperator.lessThan, toExpression(right));
}

immutable(RelationalNode) ltEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable RelationalNode(toExpression(left), RelationalOperator.lessOrEqual, toExpression(right));
}

immutable(RelationalNode) gt(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable RelationalNode(toExpression(left), RelationalOperator.greaterThan, toExpression(right));
}

immutable(RelationalNode) gtEq(LT, RT)(LT left, RT right) if(isExpressionType!(LT) && isExpressionType!(RT))
{
    return new immutable RelationalNode(toExpression(left), RelationalOperator.greaterOrEqual, toExpression(right));
}
