
module sqld.window_builder;

import sqld.ast;

struct WindowBuilder
{
private:
    immutable
    {
        string          _reference;
        PartitionByNode _partitionBy;
        OrderByNode     _orderBy;
    }

public:
    @property
    immutable(WindowDefinitionNode) build()
    {
        return new immutable WindowDefinitionNode(_reference, _partitionBy, _orderBy);
    }

    /+ - Existing Window - +/

    WindowBuilder reference(string reference)
    {
        return WindowBuilder(reference, _partitionBy, _orderBy);
    }

    WindowBuilder unreference()
    {
        return reference(null);
    }

    /+ - Partition By - +/

    WindowBuilder partitionBy(immutable(PartitionByNode) partitionBy)
    {
        return WindowBuilder(_reference, partitionBy, _orderBy);
    }

    WindowBuilder partition(T : immutable(ExpressionNode))(T partitions)
    {
        if(_partitionBy is null)
        {
            return partitionBy(new immutable PartitionByNode(partitions));
        }
        else
        {
            return partitionBy(new immutable PartitionByNode(_partitionBy.partitions ~ partitions));
        }
    }

    WindowBuilder repartition(T : immutable(ExpressionNode))(T partitions)
    {
        return unpartition.partition(partitions);
    }

    WindowBuilder unpartition()
    {
        return partitionBy(null);
    }

    /+ - Order By - +/

    WindowBuilder orderBy(immutable(OrderByNode) orderBy)
    {
        return WindowBuilder(_reference, _partitionBy, orderBy);
    }

    WindowBuilder order(T : immutable(ExpressionNode))(T directions)
    {
        if(_orderBy is null)
        {
            return orderBy(new immutable OrderByNode(directions));
        }
        else
        {
            return orderBy(new immutable OrderByNode(_orderBy.directions ~ directions));
        }
    }

    WindowBuilder reorder(T : immutable(ExpressionNode))(T directions)
    {
        return unorder.order(directions);
    }

    WindowBuilder unorder()
    {
        return orderBy(null);
    }
}
