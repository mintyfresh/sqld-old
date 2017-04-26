
module sqld.ast.with_node;

import sqld.ast.node;
import sqld.ast.select_node;
import sqld.ast.table_node;
import sqld.ast.visitor;

immutable class WithNode : Node
{
    mixin Visitable;

private:
    bool       _recursive;
    TableNode  _table;
    SelectNode _select;

public:
    this(bool recursive, immutable(TableNode) table, immutable(SelectNode) select)
    {
        _recursive = recursive;
        _table     = table;
        _select    = select;
    }

    @property
    bool recursive()
    {
        return _recursive;
    }

    @property
    immutable(TableNode) table()
    {
        return _table;
    }

    @property
    immutable(SelectNode) select()
    {
        return _select;
    }
}
