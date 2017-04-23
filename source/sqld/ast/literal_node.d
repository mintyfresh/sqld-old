
module sqld.ast.literal_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

import std.meta;
import std.variant;

alias LiteralTypes = AliasSeq!(
    bool,
    ubyte, byte, ushort, short, uint, int, ulong, long,
    float, double, real,
    size_t, ptrdiff_t, hash_t
);

class LiteralNode : ExpressionNode
{
    mixin Visitable;

private:
    Algebraic!(LiteralTypes) _value;

public:
    this(Algebraic!(LiteralTypes) value)
    {
        _value = value;
    }

    @property
    inout(Algebraic!(LiteralTypes)) value() inout
    {
        return _value;
    }
}

template isLiteralType(T)
{
    enum isLiteralType = staticIndexOf!(T, LiteralTypes) != -1;
}

@property
LiteralNode literal(T)(T value) if(isLiteralType!(T))
{
    return new LiteralNode(Algebraic!(LiteralTypes)(value));
}
