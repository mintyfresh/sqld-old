
module sqld.ast.using_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.from_node;
import sqld.ast.visitor;

immutable class UsingNode : FromNode
{
    mixin Visitable;

    this(immutable(ExpressionNode) source)
    {
        super(source);
    }

    this(immutable(ExpressionNode)[] sources)
    {
        super(sources);
    }

    this(immutable(ExpressionListNode) sources)
    {
        super(sources);
    }
}
