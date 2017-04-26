
module sqld.ast.into_node;

import sqld.ast.expression_list_node;
import sqld.ast.node;
import sqld.ast.visitor;
import sqld.ast.table_node;

immutable class IntoNode : Node
{
    mixin Visitable;

private:
    TableNode          _table;
    ExpressionListNode _columns;

public:
    this(immutable(TableNode) table, immutable(ExpressionListNode) columns)
    {
        _table   = table;
        _columns = columns;
    }

    @property
    immutable(TableNode) table()
    {
        return _table;
    }

    @property
    immutable(ExpressionListNode) columns()
    {
        return _columns;
    }
}
