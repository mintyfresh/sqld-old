
module sqld.ast.limit_node;

import sqld.ast.node;
import sqld.ast.visitor;

class LimitNode : Node
{
    mixin Visitable;

private:
    ulong _limit;

public:
    this(ulong limit) immutable
    {
        _limit = limit;
    }

    @property
    ulong limit() immutable
    {
        return _limit;
    }
}
