
module sqld.ast.query_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.subquery_node;
import sqld.ast.visitor;

abstract class QueryNode : Node
{
    mixin Visitable;

    inout(ExpressionNode) toSubquery() inout
    {
        return new inout SubqueryNode(this);
    }
}
