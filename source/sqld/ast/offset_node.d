
module sqld.ast.offset_node;

import sqld.ast.node;

class OffsetNode : Node
{
private:
    ulong _offset;

public:
    this(ulong offset)
    {
        _offset = offset;
    }

    @property
    ulong offset()
    {
        return _offset;
    }
}
