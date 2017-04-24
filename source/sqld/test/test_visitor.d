
module sqld.test.test_visitor;

import sqld.ast;

import std.array;
import std.conv;
import std.meta;
import std.traits;

class TestVisitor : Visitor
{
private:
    Appender!(string) _buffer;

public:
    @property
    string sql()
    {
        return _buffer.data;
    }

override:
    void visit(immutable(AsNode) node)
    {
        node.node.accept(this);
        _buffer ~= " AS " ~ node.name;
    }

    void visit(immutable(AssignmentNode) node)
    {
        node.left.accept(this);
        _buffer ~= " = ";
        
        if(node.right !is null)
        {
            node.right.accept(this);
        }
        else
        {
            _buffer ~= "DEFAULT";
        }
    }

    void visit(immutable(BinaryNode) node)
    {
        node.left.accept(this);
        _buffer ~= " " ~ node.operator ~ " ";
        node.right.accept(this);
    }

    void visit(immutable(ColumnNode) node)
    {
        if(node.table !is null)
        {
            node.table.accept(this);
            _buffer ~= ".";
        }

        _buffer ~= node.name;
    }

    void visit(immutable(DeleteNode) node)
    {
        _buffer ~= "DELETE ";
        
        foreach(field; AliasSeq!("from", "using", "where", "returning"))
        {
            if(__traits(getMember, node, field) !is null)
            {
                __traits(getMember, node, field).accept(this);
            }
        }
    }

    void visit(immutable(DirectionNode) node)
    {
        node.node.accept(this);
        _buffer ~= " " ~ node.direction;
    }

    void visit(immutable(ExpressionListNode) node)
    {
        foreach(index, child; node.nodes)
        {
            child.accept(this);

            if(index + 1 < node.nodes.length)
            {
                _buffer ~= ", ";
            }
        }
    }

    void visit(immutable(FromNode) node)
    {
        _buffer ~= " FROM ";
        node.sources.accept(this);
    }

    void visit(immutable(FunctionNode) node)
    {
        _buffer ~= node.name;
    }

    void visit(immutable(GroupByNode) node)
    {
        _buffer ~= " GROUP BY ";
        node.groupings.accept(this);
    }

    void visit(immutable(HavingNode) node)
    {
        _buffer ~= " HAVING ";
        node.clause.accept(this);
    }

    void visit(immutable(InsertNode) node)
    {
        _buffer ~= "INSERT ";
        
        foreach(field; AliasSeq!("into", "values", "select", "returning"))
        {
            if(__traits(getMember, node, field) !is null)
            {
                static if(field == "select") _buffer ~= " ";
                __traits(getMember, node, field).accept(this);
            }
        }
    }

    void visit(immutable(IntoNode) node)
    {
        _buffer ~= " INTO ";
        node.table.accept(this);

        if(node.columns !is null)
        {
            _buffer ~= "(";
            node.columns.accept(this);
            _buffer ~= ")";
        }
    }

    void visit(immutable(InvocationNode) node)
    {
        node.callable.accept(this);
        _buffer ~= "(";

        if(node.arguments !is null)
        {
            node.arguments.accept(this);
        }

        _buffer ~= ")";
    }

    void visit(immutable(JoinNode) node)
    {
        _buffer ~= " " ~ node.type ~ " ";
        node.source.accept(this);

        if(node.condition !is null)
        {
            _buffer ~= " ON ";
            node.condition.accept(this);
        }
    }

    void visit(immutable(LimitNode) node)
    {
        _buffer ~= " LIMIT " ~ node.limit.to!(string);
    }

    void visit(immutable(LiteralNode) node)
    {
        _buffer ~= node.value.coerce!(string);
    }

    void visit(immutable(NamedWindowNode) node)
    {
        _buffer ~= node.name ~ " AS ";
        node.definition.accept(this); 
    }

    void visit(immutable(OffsetNode) node)
    {
        _buffer ~= " OFFSET " ~ node.offset.to!(string);
    }

    void visit(immutable(OrderByNode) node)
    {
        _buffer ~= " ORDER BY ";
        node.directions.accept(this);
    }

    void visit(immutable(OverNode) node)
    {
        node.subject.accept(this);
        _buffer ~= " OVER ";

        if(node.window !is null)
        {
            node.window.accept(this);
        }
        else
        {
            _buffer ~= "()";
        }
    }

    void visit(immutable(PartitionByNode) node)
    {
        _buffer ~= " PARTITION BY ";
        node.partitions.accept(this);
    }

    void visit(immutable(ProjectionNode) node)
    {
        node.projections.accept(this);
    }

    void visit(immutable(ReturningNode) node)
    {
        _buffer ~= " RETURNING ";
        node.outputs.accept(this);
    }

    void visit(immutable(SelectNode) node)
    {
        _buffer ~= "SELECT ";
        
        foreach(field; AliasSeq!("projection", "from", "joins", "where", "groupBy",
                                 "having", "window", "orderBy", "limit", "offset"))
        {
            static if(isArray!(typeof(__traits(getMember, node, field))))
            {
                foreach(child; __traits(getMember, node, field))
                {
                    child.accept(this);
                }
            }
            else
            {
                if(__traits(getMember, node, field) !is null)
                {
                    __traits(getMember, node, field).accept(this);
                }
            }
        }
    }

    void visit(immutable(SetNode) node)
    {
        _buffer ~= " SET ";

        foreach(index, assignment; node.assignments)
        {
            assignment.accept(this);

            if(index + 1 < node.assignments.length)
            {
                _buffer ~= ", ";
            }
        }
    }

    void visit(immutable(SQLNode) node)
    {
        _buffer ~= " " ~ node.sql ~ " ";
    }

    void visit(immutable(SubqueryNode) node)
    {
        _buffer ~= "( ";
        node.query.accept(this);
        _buffer ~= " )";
    }

    void visit(immutable(TableNode) node)
    {
        if(node.schema !is null)
        {
            _buffer ~= node.schema ~ ".";
        }

        _buffer ~= node.name;
    }

    void visit(immutable(TernaryNode) node)
    {
        node.first.accept(this);
        node.second.accept(this);
        node.third.accept(this);
    }

    void visit(immutable(UnaryNode) node)
    {
        _buffer ~= node.operator ~ " ";
        node.operand.accept(this);
    }

    void visit(immutable(UpdateNode) node)
    {
        _buffer ~= "UPDATE ";
        
        foreach(field; AliasSeq!("table", "set", "from", "where", "returning"))
        {
            if(__traits(getMember, node, field) !is null)
            {
                __traits(getMember, node, field).accept(this);
            }
        }
    }

    void visit(immutable(UsingNode) node)
    {
        _buffer ~= " USING ";
        node.sources.accept(this);
    }

    void visit(immutable(ValuesNode) node)
    {
        _buffer ~= " VALUES ";
        
        foreach(index, values; node.values)
        {
            _buffer ~= "(";
            values.accept(this);
            _buffer ~= ")";

            if(index + 1 < node.values.length)
            {
                _buffer ~= ", ";
            }
        }
    }

    void visit(immutable(WhereNode) node)
    {
        _buffer ~= " WHERE ";
        node.clause.accept(this);
    }

    void visit(immutable(WindowDefinitionNode) node)
    {
        _buffer ~= "(";
        
        if(node.reference !is null)
        {
            _buffer ~= node.reference;
        }
        if(node.partitionBy !is null)
        {
            node.partitionBy.accept(this);
        }
        if(node.orderBy !is null)
        {
            node.orderBy.accept(this);
        }

        _buffer ~= " )";
    }

    void visit(immutable(WindowNode) node)
    {
        _buffer ~= " WINDOW ";

        foreach(index, window; node.windows)
        {
            window.accept(this);

            if(index + 1 < node.windows.length)
            {
                _buffer ~= ", ";
            }
        }
    }
}

@property
auto squish(string input)
{
    import std.string, std.regex : ctRegex, replaceAll;
    return input.strip.replaceAll(ctRegex!(r"\s+"), " ");
}
