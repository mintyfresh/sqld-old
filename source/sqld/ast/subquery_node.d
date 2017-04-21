
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

    @property
    QueryNode query()
    {
        return _query;
    }
}
