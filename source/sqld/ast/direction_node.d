
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
    inout(ExpressionNode) node() inout
    {
        return _node;
    }

    @property
    Direction direction() inout
    {
        return _direction;
    }
}
