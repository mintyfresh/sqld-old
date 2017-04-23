
module sqld.ast.from_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class FromNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _sources;

public:
    this(immutable(ExpressionNode) source) immutable
    {
        this(new immutable ExpressionListNode([source]));
    }

    this(immutable(ExpressionListNode) sources) immutable
    {
        _sources = sources;
    }

    @property
    immutable(ExpressionListNode) sources() immutable
    {
        return _sources;
    }
}
