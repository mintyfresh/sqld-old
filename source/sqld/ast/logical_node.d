
module sqld.ast.logical_node;

import sqld.ast.binary_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

enum LogicalOperator : string
{
    and = "AND",
    or  = "OR"
}

immutable class LogicalNode : BinaryNode
{
    mixin Visitable;

private:
    LogicalOperator _operator;

public:
    this(immutable(ExpressionNode) left, LogicalOperator operator, immutable(ExpressionNode) right)
    {
        super(left, right);
        _operator = operator;
    }

    @property
    LogicalOperator operator()
    {
        return _operator;
    }
}

immutable(LogicalNode) and(immutable(ExpressionNode) left, immutable(ExpressionNode) right)
{
    return new immutable LogicalNode(left, LogicalOperator.and, right);
}

immutable(LogicalNode) or(immutable(ExpressionNode) left, immutable(ExpressionNode) right)
{
    return new immutable LogicalNode(left, LogicalOperator.or, right);
}
