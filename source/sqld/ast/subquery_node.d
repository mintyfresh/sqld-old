
module sqld.ast.subquery_node;

import sqld.ast.expression_node;
import sqld.ast.query_node;
import sqld.ast.visitor;

class SubqueryNode : ExpressionNode
{
    mixin Visitable;

private:
    QueryNode _query;

public:
    this(immutable(QueryNode) query) immutable
    {
        _query = query;
    }

    @property
    immutable(QueryNode) query() immutable
    {
        return _query;
    }
}
