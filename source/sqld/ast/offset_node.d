
module sqld.ast.offset_node;

import sqld.ast.node;
import sqld.ast.visitor;

immutable class OffsetNode : Node
{
    mixin Visitable;

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
