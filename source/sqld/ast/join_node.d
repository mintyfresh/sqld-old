
module sqld.ast.join_node;

import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

enum JoinType : string
{
    inner = "INNER JOIN",
    left  = "LEFT OUTER JOIN",
    right = "RIGHT OUTER JOIN",
    full  = "FULL OUTER JOIN",
    cross = "CROSS JOIN"
}

class JoinNode : Node
{
    mixin Visitable;

private:
    JoinType       _type;
    ExpressionNode _source;
    ExpressionNode _condition;

public:
    this(JoinType type, immutable(ExpressionNode) source, immutable(ExpressionNode) condition) immutable
    {
        _type      = type;
        _source    = source;
        _condition = condition;
    }

    @property
    JoinType type() immutable
    {
        return _type;
    }

    @property
    immutable(ExpressionNode) source() immutable
    {
        return _source;
    }

    @property
    immutable(ExpressionNode) condition() immutable
    {
        return _condition;
    }
}
