
module sqld.ast.expression_node;

import sqld.ast.literal_node;
import sqld.ast.node;
import sqld.ast.visitor;

abstract class ExpressionNode : Node
{
    mixin Visitable;
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
