
module sqld.ast.expression_list_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

import std.algorithm;
import std.array;

class ExpressionListNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode[] _nodes;

public:
    this(immutable(ExpressionNode)[] nodes) immutable
    {
        _nodes = nodes.map!(flattenExpressionList).joiner.array;
    }

    @property
    immutable(ExpressionNode)[] nodes() immutable
    {
        return _nodes;
    }

    immutable(ExpressionListNode) opBinary(string op : "~")(immutable(ExpressionNode) node) immutable
    {
        return new immutable ExpressionListNode(nodes ~ node);
    }

    immutable(ExpressionListNode) opBinary(string op : "~")(immutable(ExpressionListNode) node) immutable
    {
        return new immutable ExpressionListNode(nodes ~ node.nodes);
    }
}

immutable(ExpressionNode)[] flattenExpressionList(immutable(ExpressionNode) node)
{
    auto list = cast(immutable(ExpressionListNode)) node;
    return list ? list.nodes : [node];
}
