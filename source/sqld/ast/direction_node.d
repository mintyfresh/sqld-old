
module sqld.ast.direction_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

enum Direction : string
{
    asc  = "ASC",
    desc = "DESC"
}

class DirectionNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode _node;
    Direction      _direction;

public:
    this(const(ExpressionNode) node, Direction direction) const
    {
        _node      = node;
        _direction = direction;
    }

    @property
    const(ExpressionNode) node() const
    {
        return _node;
    }

    @property
    Direction direction() const
    {
        return _direction;
    }
}
