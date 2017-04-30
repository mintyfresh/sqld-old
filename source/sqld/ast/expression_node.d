
module sqld.ast.expression_node;

import sqld.ast.arithmetic_node;
import sqld.ast.expression_list_node;
import sqld.ast.invocation_node;
import sqld.ast.literal_node;
import sqld.ast.node;
import sqld.ast.relational_node;

immutable abstract class ExpressionNode : Node
{
    immutable(ArithmeticNode) opBinary(string op, T)(T right)
        if(isExpressionType!(T) && (op == "+" || op == "-" || op == "*" || op == "/" || op == "%" ||
                                    op == "&" || op == "|" || op == "^" || op == "<<" || op == ">>"))
    {
        return new immutable ArithmeticNode(this, cast(ArithmeticOperator) op, toExpression(right));
    }

    immutable(ArithmeticNode) opBinaryRight(string op, T)(T left)
        if(isExpressionType!(T) && (op == "+" || op == "-" || op == "*" || op == "/" || op == "%" ||
                                    op == "&" || op == "|" || op == "^" || op == "<<" || op == ">>"))
    {
        return new immutable ArithmeticNode(toExpression(left), cast(ArithmeticOperator) op, this);
    }

    immutable(RelationalNode) opBinary(string op : "in")(immutable(ExpressionNode) node)
    {
        return new immutable RelationalNode(this, RelationalOperator.in_, node);
    }

    immutable(RelationalNode) opBinary(string op : "!in")(immutable(ExpressionNode) node)
    {
        return new immutable RelationalNode(this, RelationalOperator.notIn, node);
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

@system unittest
{
    import sqld.test.test_visitor : TestVisitor;

    auto v = new TestVisitor;
    auto n = toExpression(10) + 5;

    n.accept(v);
    assert(v.sql == "10 + 5");
}

@system unittest
{
    import sqld.test.test_visitor : TestVisitor;

    auto v = new TestVisitor;
    auto n = 5 * toExpression(10);

    n.accept(v);
    assert(v.sql == "5 * 10");
}

@system unittest
{
    import sqld.test.test_visitor : TestVisitor;

    auto v = new TestVisitor;
    auto n = toExpression(5) >> toExpression(10);

    n.accept(v);
    assert(v.sql == "5 >> 10");
}
