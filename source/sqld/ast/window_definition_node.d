
module sqld.ast.window_definition_node;

import sqld.ast.expression_node;
import sqld.ast.order_by_node;
import sqld.ast.partition_by_node;
import sqld.ast.visitor;

immutable class WindowDefinitionNode : ExpressionNode
{
    mixin Visitable;

private:
    string          _reference;
    PartitionByNode _partitionBy;
    OrderByNode     _orderBy;

public:
    this(string reference, immutable(PartitionByNode) partitionBy, immutable(OrderByNode) orderBy)
    {
        _reference   = reference;
        _partitionBy = partitionBy;
        _orderBy     = orderBy;
    }

    @property
    string reference()
    {
        return _reference;
    }

    @property
    immutable(PartitionByNode) partitionBy()
    {
        return _partitionBy;
    }

    @property
    immutable(OrderByNode) orderBy()
    {
        return _orderBy;
    }
}
