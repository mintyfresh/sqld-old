
module sqld.ast.subquery_node;

import sqld.ast.expression_node;
import sqld.ast.query_node;
import sqld.ast.visitor;

immutable class SubqueryNode : ExpressionNode
{
    mixin Visitable;

private:
    QueryNode _query;

public:
    this(immutable(QueryNode) query)
    {
        _query = query;
    }

    @property
    immutable(QueryNode) query()
    {
        return _query;
    }
}
