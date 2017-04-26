
module sqld.ast.sql_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

immutable class SQLNode : ExpressionNode
{
    mixin Visitable;

private:
    string _sql;

public:
    this(string sql)
    {
        _sql = sql;
    }

    @property
    string sql()
    {
        return _sql;
    }
}

@property
immutable(SQLNode) sql(string sql)
{
    return new immutable SQLNode(sql);
}
