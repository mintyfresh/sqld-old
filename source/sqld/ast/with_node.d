
module sqld.ast.with_node;

import sqld.ast.node;
import sqld.ast.select_node;
import sqld.ast.table_node;
import sqld.ast.visitor;

class WithNode : Node
{
    mixin Visitable;

private:
    bool       _recursive;
    TableNode  _table;
    SelectNode _select;

public:
    this(bool recursive, immutable(TableNode) table, immutable(SelectNode) select) immutable
    {
        _recursive = recursive;
        _table     = table;
        _select    = select;
    }

    @property
    bool recursive() immutable
    {
        return _recursive;
    }

    @property
    immutable(TableNode) table() immutable
    {
        return _table;
    }

    @property
    immutable(SelectNode) select() immutable
    {
        return _select;
    }
}
