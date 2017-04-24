
module sqld.ast.window_node;

import sqld.ast.named_window_node;
import sqld.ast.node;
import sqld.ast.visitor;

class WindowNode : Node
{
    mixin Visitable;

private:
    NamedWindowNode[] _windows;

public:
    this(immutable(NamedWindowNode) window) immutable
    {
        this([window]);
    }

    this(immutable(NamedWindowNode)[] windows) immutable
    {
        _windows = windows;
    }

    @property
    immutable(NamedWindowNode)[] windows() immutable
    {
        return _windows;
    }
}
