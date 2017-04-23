
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
    this(JoinType type, const(ExpressionNode) source, const(ExpressionNode) condition) const
    {
        _type      = type;
        _source    = source;
        _condition = condition;
    }

    @property
    JoinType type() const
    {
        return _type;
    }

    @property
    const(ExpressionNode) source() const
    {
        return _source;
    }

    @property
    const(ExpressionNode) condition() const
    {
        return _condition;
    }
}
