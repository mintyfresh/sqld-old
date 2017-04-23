
module sqld.ast.sql_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

class SQLNode : ExpressionNode
{
    mixin Visitable;

private:
    string _sql;

public:
    this(string sql) immutable
    {
        _sql = sql;
    }

    @property
    string sql() immutable
    {
        return _sql;
    }
}

@property
immutable(SQLNode) sql(string sql)
{
    return new immutable SQLNode(sql);
}
