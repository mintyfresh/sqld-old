
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

    @property
    ExpressionNode[] nodes()
    {
        return _nodes;
    }

    ExpressionListNode opBinary(string op : "~")(ExpressionNode node)
    {
        return new ExpressionListNode(nodes ~ node);
    }

    ExpressionListNode opBinary(string op : "~")(ExpressionListNode node)
    {
        return new ExpressionListNode(nodes ~ node.nodes);
    }
}

ExpressionNode[] flattenExpressionList(ExpressionNode node)
{
    auto list = cast(ExpressionListNode) node;
    return list ? list.nodes : [node];
}
