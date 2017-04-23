
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
    this(const(ExpressionNode) source) const
    {
        this(new const ExpressionListNode([source]));
    }

    this(const(ExpressionListNode) sources) const
    {
        _sources = sources;
    }

    @property
    const(ExpressionListNode) sources() const
    {
        return _sources;
    }
}
