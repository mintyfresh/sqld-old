
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
    this(const(ExpressionNode) callable, const(ExpressionNode)[] arguments) const
    {
        this(callable, new const ExpressionListNode(arguments));
    }

    this(const(ExpressionNode) callable, const(ExpressionListNode) arguments = null) const
    {
        _callable  = callable;
        _arguments = arguments;
    }

    @property
    const(ExpressionNode) callable() const
    {
        return _callable;
    }

    @property
    const(ExpressionListNode) arguments() const
    {
        return _arguments;
    }
}

@property
const(InvocationNode) avg(const(ExpressionNode) node)
{
    return new const FunctionNode(FunctionName.avg).opCall([node]);
}

@property
const(InvocationNode) count(const(ExpressionNode) node)
{
    return new const FunctionNode(FunctionName.count).opCall([node]);
}

@property
const(InvocationNode) max(const(ExpressionNode) node)
{
    return new const FunctionNode(FunctionName.max).opCall([node]);
}

@property
const(InvocationNode) min(const(ExpressionNode) node)
{
    return new const FunctionNode(FunctionName.min).opCall([node]);
}

@property
const(InvocationNode) sum(const(ExpressionNode) node)
{
    return new const FunctionNode(FunctionName.sum).opCall([node]);
}
