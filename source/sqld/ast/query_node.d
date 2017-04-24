
module sqld.ast.query_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.subquery_node;

abstract class QueryNode : Node
{
    immutable(ExpressionNode) toSubquery() immutable
    {
        return new immutable SubqueryNode(this);
    }
}
