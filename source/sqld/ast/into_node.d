
module sqld.ast.into_node;

import sqld.ast.expression_list_node;
import sqld.ast.node;
import sqld.ast.table_node;

class IntoNode : Node
{
private:
    TableNode          _table;
    ExpressionListNode _columns;

public:
    this(immutable(TableNode) table, immutable(ExpressionListNode) columns) immutable
    {
        _table   = table;
        _columns = columns;
    }

    @property
    immutable(TableNode) table() immutable
    {
        return _table;
    }

    @property
    immutable(ExpressionListNode) columns() immutable
    {
        return _columns;
    }
}
