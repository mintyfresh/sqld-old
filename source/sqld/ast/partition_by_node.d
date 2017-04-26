
module sqld.ast.partition_by_node;

import sqld.ast.expression_list_node;
import sqld.ast.expression_node;
import sqld.ast.node;
import sqld.ast.visitor;

immutable class PartitionByNode : Node
{
    mixin Visitable;

private:
    ExpressionListNode _partitions;

public:
    this(immutable(ExpressionNode) partitions)
    {
        _partitions = new immutable ExpressionListNode([partitions]);
    }

    this(immutable(ExpressionListNode) partitions)
    {
        _partitions = partitions;
    }

    @property
    immutable(ExpressionListNode) partitions()
    {
        return _partitions;
    }
}
