
module sqld.ast.expression_node;

import sqld.ast.binary_node;
import sqld.ast.expression_list_node;
import sqld.ast.invocation_node;
import sqld.ast.literal_node;
import sqld.ast.node;
import sqld.ast.visitor;

abstract class ExpressionNode : Node
{
    mixin Visitable;

    const(BinaryNode) opBinary(string op : "in")(const(ExpressionNode) node) const
    {
        return new const BinaryNode(this, BinaryOperator.in_, node);
    }

    const(BinaryNode) opBinary(string op : "!in")(const(ExpressionNode) node) const
    {
        return new const BinaryNode(this, BinaryOperator.notIn, node);
    }

    const(InvocationNode) opCall(const(ExpressionNode)[] arguments) const
    {
        return new const InvocationNode(this, arguments);
    }

    const(InvocationNode) opCall(const(ExpressionListNode) arguments) const
    {
        return new const InvocationNode(this, arguments);
    }
}

template isExpressionType(T)
{
    enum isExpressionType = is(T : const(ExpressionNode)) || isLiteralType!(T);
}

@property
const(ExpressionNode) expression(T : const(ExpressionNode))(T node)
{
    return node;
}

@property
const(ExpressionNode) expression(T)(T value) if(isLiteralType!(T))
{
    return literal(value);
}
