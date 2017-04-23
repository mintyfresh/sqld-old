
module sqld.ast.node;

import sqld.ast.visitor;

abstract class Node
{
    void accept(Visitor visitor) immutable
    {
        visitor.visit(this);
    }
}
