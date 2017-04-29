
module sqld.ast.invocation_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.function_node;
import sqld.ast.visitor;

import std.meta : allSatisfy;

immutable class InvocationNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode     _callable;
    ExpressionListNode _arguments;

public:
    this(immutable(ExpressionNode) callable, immutable(ExpressionNode)[] arguments)
    {
        this(callable, new immutable ExpressionListNode(arguments));
    }

    this(immutable(ExpressionNode) callable, immutable(ExpressionListNode) arguments = null)
    {
        _callable  = callable;
        _arguments = arguments;
    }

    @property
    immutable(ExpressionNode) callable()
    {
        return _callable;
    }

    @property
    immutable(ExpressionListNode) arguments()
    {
        return _arguments;
    }
}

@property
immutable(InvocationNode) avg(immutable(ExpressionNode) node)
{
    return new immutable FunctionNode(FunctionName.avg).opCall([node]);
}

@property
immutable(InvocationNode) count(immutable(ExpressionNode) node)
{
    return new immutable FunctionNode(FunctionName.count).opCall([node]);
}

@property
immutable(InvocationNode) max(immutable(ExpressionNode) node)
{
    return new immutable FunctionNode(FunctionName.max).opCall([node]);
}

@property
immutable(InvocationNode) min(immutable(ExpressionNode) node)
{
    return new immutable FunctionNode(FunctionName.min).opCall([node]);
}

@property
immutable(InvocationNode) sum(immutable(ExpressionNode) node)
{
    return new immutable FunctionNode(FunctionName.sum).opCall([node]);
}

immutable(FunctionNode) func(TList...)(string name, TList args)
    if(allSatisfy!(isExpressionType, TList))
{
    return new immutable FunctionNode(name).opCall(toExpressionList(args));
}

@system unittest
{
    import sqld.ast;
    import sqld.test.test_visitor;

    auto v = new TestVisitor;
    auto n = sum(new immutable ColumnNode("test"));

    n.accept(v);
    assert(v.sql == "SUM(test)");
}
