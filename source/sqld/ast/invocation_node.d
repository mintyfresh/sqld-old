
module sqld.ast.invocation_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.function_node;
import sqld.ast.visitor;

class InvocationNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode     _callable;
    ExpressionListNode _arguments;

public:
    this(immutable(ExpressionNode) callable, immutable(ExpressionNode)[] arguments) immutable
    {
        this(callable, new immutable ExpressionListNode(arguments));
    }

    this(immutable(ExpressionNode) callable, immutable(ExpressionListNode) arguments = null) immutable
    {
        _callable  = callable;
        _arguments = arguments;
    }

    @property
    immutable(ExpressionNode) callable() immutable
    {
        return _callable;
    }

    @property
    immutable(ExpressionListNode) arguments() immutable
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
