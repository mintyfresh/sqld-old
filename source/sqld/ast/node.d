
module sqld.ast.node;

import sqld.ast.visitor;

abstract class Node
{
    void accept(Visitor) immutable
    {
        assert(0, "Attempt to visit Node. (" ~ this.classinfo.name ~ ")");
    }
}
