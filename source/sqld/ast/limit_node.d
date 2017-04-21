
module sqld.ast.limit_node;

import sqld.ast.node;

class LimitNode : Node
{
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
