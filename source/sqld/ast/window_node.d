
module sqld.ast.window_node;

import sqld.ast.named_window_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class WindowNode : Node
{
    mixin Visitable;

private:
    NamedWindowNode[] _windows;

public:
    this(immutable(NamedWindowNode) window)
    {
        this([window]);
    }

    this(immutable(NamedWindowNode)[] windows)
    {
        _windows = windows;
    }

    @property
    immutable(NamedWindowNode)[] windows()
    {
        return _windows;
    }
}
