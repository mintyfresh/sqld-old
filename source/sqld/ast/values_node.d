
module sqld.ast.values_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class ValuesNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode[] _values;

public:
    this(immutable(ExpressionNode)[] values)
    {
        this(new immutable(ExpressionListNode)(values));
    }

    this(immutable(ExpressionListNode) values)
    {
        this([values]);
    }

    this(immutable(ExpressionListNode)[] values)
    {
        _values = values;
    }

    @property
    immutable(ExpressionListNode)[] values()
    {
        return _values;
    }
}
