
module sqld.ast.offset_node;

import sqld.ast.node;
import sqld.ast.visitor;

class OffsetNode : Node
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
    ulong offset() const
    {
        return _offset;
    }
}
