
module sqld.builder;

mixin template Builder()
{
    import std.algorithm;
    import std.array;
    import std.meta;
    import std.traits;

private:
    alias NodeType = ReturnType!(__traits(getMember, typeof(this), "build"));

    static typeof(this) copy(NodeType original)
    {
        mixin("return typeof(this).init" ~ [FieldNameTuple!(typeof(this))]
            .map!(f => "." ~ f[1..$] ~ "(original." ~ f[1..$] ~ ")").join ~ ";");
    }

    typeof(this) next(string name, T)(T value) if(__traits(hasMember, typeof(this), "_" ~ name))
    {
        return typeof(this)(Replace!(mixin("_" ~ name), value, this.tupleof));
    }
}
