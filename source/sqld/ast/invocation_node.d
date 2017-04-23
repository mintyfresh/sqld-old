
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
    this(ExpressionNode callable, ExpressionNode[] arguments)
    {
        this(callable, new ExpressionListNode(arguments));
    }

    this(ExpressionNode callable, ExpressionListNode arguments = null)
    {
        _callable  = callable;
        _arguments = arguments;
    }

    @property
    ExpressionNode callable()
    {
        return _callable;
    }

    @property
    ExpressionListNode arguments()
    {
        return _arguments;
    }
}

@property
InvocationNode avg(ExpressionNode node)
{
    return new FunctionNode(FunctionName.avg).opCall([node]);
}

@property
InvocationNode count(ExpressionNode node)
{
    return new FunctionNode(FunctionName.count).opCall([node]);
}

@property
InvocationNode max(ExpressionNode node)
{
    return new FunctionNode(FunctionName.max).opCall([node]);
}

@property
InvocationNode min(ExpressionNode node)
{
    return new FunctionNode(FunctionName.min).opCall([node]);
}

@property
InvocationNode sum(ExpressionNode node)
{
    return new FunctionNode(FunctionName.sum).opCall([node]);
}
