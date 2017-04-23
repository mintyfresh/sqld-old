
module sqld.ast.sql_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

class SQLNode : ExpressionNode
{
    mixin Visitable;

private:
    string _sql;

public:
    this(string sql) const
    {
        _sql = sql;
    }

    @property
    string sql() const
    {
        return _sql;
    }
}

@property
const(SQLNode) sql(string sql)
{
    return new const SQLNode(sql);
}
