
module sqld.ast.set_node;

import sqld.ast.assignment_node;
import sqld.ast.node;
import sqld.ast.visitor;

class SetNode : Node
{
    mixin Visitable;

private:
    AssignmentNode[] _assignments;

public:
    this(immutable(AssignmentNode) assignment) immutable
    {
        this([assignment]);
    }

    this(immutable(AssignmentNode)[] assignments) immutable
    {
        _assignments = assignments;
    }

    @property
    immutable(AssignmentNode)[] assignments() immutable
    {
        return _assignments;
    }
}
