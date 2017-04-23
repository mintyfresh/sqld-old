
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
    this(const(QueryNode) query) const
    {
        _query = query;
    }

    @property
    const(QueryNode) query() const
    {
        return _query;
    }
}
