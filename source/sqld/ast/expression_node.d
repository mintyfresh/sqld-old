
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

    BinaryNode opBinary(string op : "in")(ExpressionNode node)
    {
        return new BinaryNode(this, BinaryOperator.in_, node);
    }

    BinaryNode opBinary(string op : "!in")(ExpressionNode node)
    {
        return new BinaryNode(this, BinaryOperator.notIn, node);
    }

    InvocationNode opCall(ExpressionNode[] arguments)
    {
        return new InvocationNode(this, arguments);
    }

    InvocationNode opCall(ExpressionListNode arguments)
    {
        return new InvocationNode(this, arguments);
    }
}

template isExpressionType(T)
{
    enum isExpressionType = is(T : ExpressionNode) || isLiteralType!(T);
}

@property
ExpressionNode expression(T : ExpressionNode)(T node)
{
    return node;
}

@property
ExpressionNode expression(T)(T value) if(isLiteralType!(T))
{
    return literal(value);
}
