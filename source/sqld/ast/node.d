
module sqld.ast.node;

import sqld.ast.visitor;

immutable abstract class Node
{
    void accept(Visitor)
    {
        assert(0, "Attempt to visit Node. (" ~ this.classinfo.name ~ ")");
    }
}
