
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
    this(ExpressionNode source)
    {
        this(new ExpressionListNode([source]));
    }

    this(ExpressionListNode sources)
    {
        _sources = sources;
    }

    @property
    inout(ExpressionListNode) sources() inout
    {
        return _sources;
    }
}
