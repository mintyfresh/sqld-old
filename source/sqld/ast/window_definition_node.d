
module sqld.ast.window_definition_node;

import sqld.ast.expression_node;
import sqld.ast.order_by_node;
import sqld.ast.partition_by_node;
import sqld.ast.visitor;

class WindowDefinitionNode : ExpressionNode
{
    mixin Visitable;

private:
    string          _existingWindow;
    PartitionByNode _partitionBy;
    OrderByNode     _orderBy;

public:
    this(string existingWindow, immutable(PartitionByNode) partitionBy, immutable(OrderByNode) orderBy) immutable
    {
        _existingWindow = existingWindow;
        _partitionBy    = partitionBy;
        _orderBy        = orderBy;
    }

    @property
    string existingWindow() immutable
    {
        return _existingWindow;
    }

    @property
    immutable(PartitionByNode) partitionBy() immutable
    {
        return _partitionBy;
    }

    @property
    immutable(OrderByNode) orderBy() immutable
    {
        return _orderBy;
    }
}
