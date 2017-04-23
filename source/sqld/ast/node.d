
module sqld.ast.node;

import sqld.ast.visitor;

abstract class Node
{
    void accept(Visitor visitor) const
    {
        visitor.visit(this);
    }
}
