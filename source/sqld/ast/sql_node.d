
module sqld.ast.sql;

import sqld.ast.expression_node;

class SQLNode : ExpressionNode
{
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
