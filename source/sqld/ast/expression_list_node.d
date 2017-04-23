
module sqld.ast.expression_list_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

import std.algorithm;
import std.array;

class ExpressionListNode : ExpressionNode
{
    mixin Visitable;

private:
    const(ExpressionNode)[] _nodes;

public:
    this(const(ExpressionNode)[] nodes) const
    {
        _nodes = nodes.map!(flattenExpressionList).joiner.array;
    }

    @property
    const(ExpressionNode)[] nodes() const
    {
        return _nodes;
    }

    const(ExpressionListNode) opBinary(string op : "~")(const(ExpressionNode) node) const
    {
        return new const ExpressionListNode(nodes ~ node);
    }

    const(ExpressionListNode) opBinary(string op : "~")(const(ExpressionListNode) node) const
    {
        return new const ExpressionListNode(nodes ~ node.nodes);
    }
}

const(ExpressionNode)[] flattenExpressionList(const(ExpressionNode) node)
{
    auto list = cast(const(ExpressionListNode)) node;
    return list ? list.nodes : [node];
}
