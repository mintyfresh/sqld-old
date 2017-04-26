
module sqld.ast.query_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.subquery_node;

immutable abstract class QueryNode : Node
{
    immutable(ExpressionNode) toSubquery()
    {
        return new immutable SubqueryNode(this);
    }
}
