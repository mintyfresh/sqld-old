
module sqld.ast.limit_node;

import sqld.ast.node;
import sqld.ast.visitor;

immutable class LimitNode : Node
{
    mixin Visitable;

private:
    ulong _limit;

public:
    this(ulong limit)
    {
        _limit = limit;
    }

    @property
    ulong limit()
    {
        return _limit;
    }
}
