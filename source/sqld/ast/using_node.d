
module sqld.ast.using_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.from_node;
import sqld.ast.visitor;

class UsingNode : FromNode
{
    mixin Visitable;

    this(immutable(ExpressionNode) source) immutable
    {
        super(source);
    }

    this(immutable(ExpressionNode)[] sources) immutable
    {
        super(sources);
    }

    this(immutable(ExpressionListNode) sources) immutable
    {
        super(sources);
    }
}
