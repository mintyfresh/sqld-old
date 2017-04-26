
module sqld.ast.set_node;

import sqld.ast.assignment_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class SetNode : Node
{
    mixin Visitable;

private:
    AssignmentNode[] _assignments;

public:
    this(immutable(AssignmentNode) assignment)
    {
        this([assignment]);
    }

    this(immutable(AssignmentNode)[] assignments)
    {
        _assignments = assignments;
    }

    @property
    immutable(AssignmentNode)[] assignments()
    {
        return _assignments;
    }
}
