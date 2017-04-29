
module sqld.ast.parameter_node;

import sqld.ast.expression_node;
import sqld.ast.literal_node;
import sqld.ast.visitor;

immutable class ParameterNode : ExpressionNode
{
    mixin Visitable;

private:
    LiteralNode _value;
    string      _name;

public:
    this(immutable(LiteralNode) value, string name = null)
    {
        _value = value;
        _name  = name;
    }

    @property
    immutable(LiteralNode) value()
    {
        return _value;
    }

    @property
    string name()
    {
        return _name;
    }
}

immutable(ParameterNode) parameter(T)(T value, string name = null) if(isLiteralType!(T))
{
    return new immutable ParameterNode(literal(value), name);
}
