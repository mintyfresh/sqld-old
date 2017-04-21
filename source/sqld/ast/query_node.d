
module sqld.ast.query_node;

import sqld.ast.node;
import sqld.ast.visitor;

abstract class QueryNode : Node
{
    mixin Visitable;
}
