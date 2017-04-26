
module sqld.ast.union_node;

import sqld.ast.node;
import sqld.ast.select_node;
import sqld.ast.visitor;

enum UnionType : string
{
    distinct = "DISTINCT",
    all      = "ALL"
}

immutable class UnionNode : Node
{
    mixin Visitable;

private:
    UnionType  _type;
    SelectNode _select;

public:
    this(immutable(SelectNode) select)
    {
        this(UnionType.distinct, select);
    }

    this(UnionType type, immutable(SelectNode) select)
    {
        _type   = type;
        _select = select;
    }

    @property
    UnionType type()
    {
        return _type;
    }

    @property
    immutable(SelectNode) select()
    {
        return _select;
    }
}
