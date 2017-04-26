
module sqld.ast.expression_node;

import sqld.ast.binary_node;
import sqld.ast.expression_list_node;
import sqld.ast.invocation_node;
import sqld.ast.literal_node;
import sqld.ast.node;

immutable abstract class ExpressionNode : Node
{
    immutable(BinaryNode) opBinary(string op : "in")(immutable(ExpressionNode) node)
    {
        return new immutable BinaryNode(this, BinaryOperator.in_, node);
    }

    immutable(BinaryNode) opBinary(string op : "!in")(immutable(ExpressionNode) node)
    {
        return new immutable BinaryNode(this, BinaryOperator.notIn, node);
    }

    immutable(InvocationNode) opCall(immutable(ExpressionNode)[] arguments)
    {
        return new immutable InvocationNode(this, arguments);
    }

    immutable(InvocationNode) opCall(immutable(ExpressionListNode) arguments)
    {
        return new immutable InvocationNode(this, arguments);
    }
}

template isExpressionType(T)
{
    enum isExpressionType = is(T : immutable(ExpressionNode)) || isLiteralType!(T);
}

@property
immutable(ExpressionNode) toExpression(T : immutable(ExpressionNode))(T node)
{
    return node;
}

@property
immutable(ExpressionNode) toExpression(T)(T value) if(isLiteralType!(T))
{
    return literal(value);
}
