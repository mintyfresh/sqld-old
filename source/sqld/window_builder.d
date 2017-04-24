
module sqld.window_builder;

import sqld.ast;
import sqld.builder;
import sqld.partials;

struct WindowBuilder
{
    mixin Builder;
    mixin OrderByPartial;

private:
    immutable
    {
        string          _reference;
        PartitionByNode _partitionBy;
    }

public:
    alias build this;

    @property
    immutable(WindowDefinitionNode) build()
    {
        return new immutable WindowDefinitionNode(_reference, _partitionBy, _orderBy);
    }

    /+ - Existing Window - +/

    WindowBuilder reference(string reference)
    {
        return next!("reference")(reference);
    }

    WindowBuilder unreference()
    {
        return reference(null);
    }

    /+ - Partition By - +/

    WindowBuilder partitionBy(immutable(PartitionByNode) partitionBy)
    {
        return next!("partitionBy")(partitionBy);
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
}
