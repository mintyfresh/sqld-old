
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
    this(ExpressionNode node, Direction direction)
    {
        _node      = node;
        _direction = direction;
    }

    @property
    ExpressionNode node()
    {
        return _node;
    }

    @property
    Direction direction()
    {
        return _direction;
    }
}
