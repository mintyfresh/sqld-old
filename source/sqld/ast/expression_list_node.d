
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
    this(ExpressionNode[] nodes)
    {
        _nodes = nodes.map!(flattenExpressionList).joiner.array;
    }

    this(inout(ExpressionNode)[] nodes) inout
    {
        auto mutable = cast(ExpressionNode[]) nodes; // HACK : Can't .map!() inout array.
        _nodes = cast(inout(ExpressionNode)[]) mutable.map!(flattenExpressionList).joiner.array;
    }

    @property
    inout(ExpressionNode)[] nodes() inout
    {
        return _nodes;
    }

    inout(ExpressionListNode) opBinary(string op : "~")(inout(ExpressionNode) node) inout
    {
        return new inout ExpressionListNode(nodes ~ node);
    }

    inout(ExpressionListNode) opBinary(string op : "~")(inout(ExpressionListNode) node) inout
    {
        return new inout ExpressionListNode(nodes ~ node.nodes);
    }
}

inout(ExpressionNode)[] flattenExpressionList(inout ExpressionNode node)
{
    auto list = cast(inout ExpressionListNode) node;
    return list ? list.nodes : [node];
}
