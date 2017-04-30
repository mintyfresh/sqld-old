
module sqld.ast.into_node;

import sqld.ast.column_node;
import sqld.ast.node;
import sqld.ast.table_node;
import sqld.ast.visitor;

import std.array;

immutable class IntoNode : Node
{
    mixin Visitable;

private:
    TableNode    _table;
    ColumnNode[] _columns;

public:
    this(immutable(TableNode) table, immutable(ColumnNode)[] columns...)
    {
        _table   = table;
        _columns = columns ? columns.array : null;
    }

    @property
    immutable(TableNode) table()
    {
        return _table;
    }

    @property
    immutable(ColumnNode)[] columns()
    {
        return _columns;
    }
}
