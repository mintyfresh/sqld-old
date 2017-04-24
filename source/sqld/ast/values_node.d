
module sqld.ast.values_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

class ValuesNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode[] _values;

public:
    this(immutable(ExpressionNode)[] values) immutable
    {
        this(new immutable(ExpressionListNode)(values));
    }

    this(immutable(ExpressionListNode) values) immutable
    {
        this([values]);
    }

    this(immutable(ExpressionListNode)[] values) immutable
    {
        _values = values;
    }

    @property
    immutable(ExpressionListNode)[] values() immutable
    {
        return _values;
    }
}
