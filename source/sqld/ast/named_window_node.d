
module sqld.ast.named_window_node;

import sqld.ast.node;
import sqld.ast.window_definition_node;
import sqld.ast.visitor;

class NamedWindowNode : Node
{
    mixin Visitable;

private:
    string               _name;
    WindowDefinitionNode _definition;

public:
    this(string name, immutable(WindowDefinitionNode) definition) immutable
    {
        _name       = name;
        _definition = definition;
    }

    @property
    string name() immutable
    {
        return _name;
    }

    @property
    immutable(WindowDefinitionNode) definition() immutable
    {
        return _definition;
    }
}
