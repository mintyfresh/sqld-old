
module sqld.ast.from_node;

import sqld.ast.expression_node;
import sqld.ast.node;

class FromNode : Node
{
private:
    ExpressionNode _source;

public:
    this(ExpressionNode source)
    {
        _source = source;
    }

    @property
    ExpressionNode source()
    {
        return _source;
    }
}
