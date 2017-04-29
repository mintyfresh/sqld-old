
module sqld.ast.between_node;

import sqld.ast.expression_node;
import sqld.ast.ternary_node;
import sqld.ast.visitor;

immutable class BetweenNode : TernaryNode
{
    mixin Visitable;

    this(immutable(ExpressionNode) first, immutable(ExpressionNode) second, immutable(ExpressionNode) third)
    {
        super(first, second, third);
    }
}

immutable(BetweenNode) between(T1, T2, T3)(T1 first, T2 second, T3 third)
    if(isExpressionType!(T1) && isExpressionType!(T2) && isExpressionType!(T3))
{
    return new immutable BetweenNode(toExpression(first), toExpression(second), toExpression(third));
}

@system unittest
{
    import sqld.ast.table_node : table;
    import sqld.test.test_visitor : TestVisitor;

    auto v = new TestVisitor;
    auto n = 10.between(5, 15);

    n.accept(v);
    assert(v.sql == "10 BETWEEN 5 AND 15");
}
