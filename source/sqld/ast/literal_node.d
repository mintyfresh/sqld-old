
module sqld.ast.literal_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

import std.meta;
import std.variant;

private template TypeAndTypeArray(T)
{
    alias TypeAndTypeArray = AliasSeq!(T, T[]);
}

alias LiteralTypes = staticMap!(TypeAndTypeArray, AliasSeq!(
    bool,
    ubyte, byte, ushort, short, uint, int, ulong, long,
    float, double, real,
    size_t, ptrdiff_t, hash_t
));

class LiteralNode : ExpressionNode
{
    mixin Visitable;

private:
    Algebraic!(LiteralTypes) _value;

public:
    this(Algebraic!(LiteralTypes) value) immutable
    {
        _value = value;
    }

    @property
    Algebraic!(LiteralTypes) value() immutable
    {
        return _value;
    }
}

template isLiteralType(T)
{
    enum isLiteralType = staticIndexOf!(T, LiteralTypes) != -1;
}

@property
immutable(LiteralNode) literal(T)(T value) if(isLiteralType!(T))
{
    return new immutable LiteralNode(Algebraic!(LiteralTypes)(value));
}
