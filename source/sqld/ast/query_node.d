
module sqld.ast.query_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.subquery_node;
import sqld.ast.visitor;

abstract class QueryNode : Node
{
    mixin Visitable;

    immutable(ExpressionNode) toSubquery() immutable
    {
        return new immutable SubqueryNode(this);
    }
}
