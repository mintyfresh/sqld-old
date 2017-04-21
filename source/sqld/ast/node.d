
module sqld.ast.node;

import sqld.ast.visitor;

abstract class Node
{
    void accept(Visitor visitor)
    {
        visitor.visit(this);
    }
}
