
module sqld.ast.from_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class FromNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _sources;

public:
    this(immutable(ExpressionNode) source)
    {
        this([source]);
    }

    this(immutable(ExpressionNode)[] sources)
    {
        this(new immutable ExpressionListNode(sources));
    }

    this(immutable(ExpressionListNode) sources)
    {
        _sources = sources;
    }

    @property
    immutable(ExpressionListNode) sources()
    {
        return _sources;
    }
}

version(unittest)
{
    import sqld.ast;
    import sqld.test.test_visitor;
}

@system unittest
{
    auto v = new TestVisitor;
    auto n = new immutable FromNode(TableNode("foo"));

    n.accept(v);
    assert(v.sql.squish == "FROM foo");
}

@system unittest
{
    auto v = new TestVisitor;
    auto n = new immutable FromNode([TableNode("foo"), TableNode("bar"), TableNode("foobar")]);

    n.accept(v);
    assert(v.sql.squish == "FROM foo, bar, foobar");
}

