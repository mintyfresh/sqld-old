
module sqld.ast.literal_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

import std.algorithm;
import std.array;
import std.meta;
import std.traits;
import std.variant;

private template TypeAndTypeArray(T)
{
    alias TypeAndTypeArray = AliasSeq!(T, T[]);
}

alias LiteralTypes = staticMap!(TypeAndTypeArray, AliasSeq!(
    bool,
    ubyte, byte, ushort, short, uint, int, ulong, long,
    float, double, real,
    size_t, ptrdiff_t, hash_t,
    string, wstring, dstring,
    LiteralType
));

/++
 + An abritrary Database specific literal type.
 +/
interface LiteralType
{
    /++
     + Converts the literal type to its SQL representation.
     + By nature of its design, the result is Database specific in most cases.
     +
     + Returns:
     +   A SQL representation of this literal value. 
     +/
    @property
    string sql();
}

immutable class LiteralNode : ExpressionNode
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
    Algebraic!(LiteralTypes) value()
    {
        return _value;
    }
}

/++
 + Tests if a type is (or is convertible to) a literal type.
 +
 + Params:
 +   T - A type.
 +/
template isLiteralType(T)
{
    enum isLiteralType = staticIndexOf!(T, LiteralTypes) != -1 || is(T : LiteralType) ||
                         (isArray!(T) && is(ForeachType!(T) : LiteralType));
}

/++
 + Converts a literal value or type wrapper into an AST literal node.
 +
 + Params:
 +   value - The value being converted.
 +
 + Returns:
 +   An AST literal node.
 +/
@property
immutable(LiteralNode) literal(T)(T value) if(isLiteralType!(T))
{
    static if(is(T : LiteralType))
    {
        LiteralType stored = cast(LiteralType) value;
    }
    else static if(isArray!(T) && is(ForeachType!(T) : LiteralType))
    {
        LiteralType[] stored = value.map!(v => cast(LiteralType) v).array;
    }
    else
    {
        T stored = value;
    }

    return new immutable LiteralNode(Algebraic!(LiteralTypes)(stored));
}

@system unittest
{
    import sqld.test.test_visitor : TestVisitor;

    static class TestType : LiteralType
    {
        @property
        override string sql()
        {
            return "test";
        }

        @property
        override string toString()
        {
            return "test";
        }
    }

    auto v = new TestVisitor;
    auto n = literal([new TestType, new TestType, new TestType]);

    n.accept(v);
    assert(v.sql == "[test, test, test]");
}
