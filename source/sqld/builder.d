
module sqld.builder;

mixin template Builder()
{
    import std.meta;

private:
    typeof(this) next(string name, T)(T value) if(__traits(hasMember, typeof(this), "_" ~ name))
    {
        return typeof(this)(Replace!(mixin("_" ~ name), value, this.tupleof));
    }
}
