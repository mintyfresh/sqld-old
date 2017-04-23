
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
    this(QueryNode query)
    {
        _query = query;
    }

    this(inout(QueryNode) query) inout
    {
        _query = query;
    }

    @property
    inout(QueryNode) query() inout
    {
        return _query;
    }
}
