
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
    void visit(AsNode node)
    {
        node.node.accept(this);
        _buffer ~= " AS " ~ node.name;
    }

    void visit(BinaryNode node)
    {
        node.left.accept(this);
        _buffer ~= " " ~ node.operator ~ " ";
        node.right.accept(this);
    }

    void visit(ColumnNode node)
    {
        if(node.table !is null)
        {
            node.table.accept(this);
            _buffer ~= ".";
        }

        _buffer ~= node.name;
    }

    void visit(DirectionNode node)
    {
        node.node.accept(this);
        _buffer ~= " " ~ node.direction;
    }

    void visit(ExpressionListNode node)
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

    void visit(ExpressionNode node)
    {
        assert(0, node.classinfo.name);
    }

    void visit(FromNode node)
    {
        _buffer ~= " FROM ";
        node.sources.accept(this);
    }

    void visit(GroupByNode node)
    {
        _buffer ~= " GROUP BY ";
        node.groupings.accept(this);
    }

    void visit(HavingNode node)
    {
        _buffer ~= " HAVING ";
        node.clause.accept(this);
    }

    void visit(JoinNode node)
    {
        _buffer ~= " " ~ node.type ~ " ";
        node.source.accept(this);

        if(node.condition !is null)
        {
            _buffer ~= " ON ";
            node.condition.accept(this);
        }
    }

    void visit(LimitNode node)
    {
        _buffer ~= " LIMIT " ~ node.limit.to!(string);
    }

    void visit(LiteralNode node)
    {
        _buffer ~= node.value.coerce!(string);
    }

    void visit(Node node)
    {
        assert(0, node.classinfo.name);
    }

    void visit(OffsetNode node)
    {
        _buffer ~= " OFFSET " ~ node.offset.to!(string);
    }

    void visit(OrderByNode node)
    {
        _buffer ~= " ORDER BY ";
        node.directions.accept(this);
    }

    void visit(ProjectionNode node)
    {
        node.projections.accept(this);
    }

    void visit(QueryNode node)
    {
        assert(0, node.classinfo.name);
    }

    void visit(SelectNode node)
    {
        _buffer ~= "SELECT ";
        
        foreach(field; AliasSeq!("projection", "from", "joins", "where", "groupBy",
                                 "having", "orderBy", "limit", "offset"))
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

    void visit(SQLNode node)
    {
        _buffer ~= " " ~ node.sql ~ " ";
    }

    void visit(SubqueryNode node)
    {
        node.query.accept(this);
    }

    void visit(TableNode node)
    {
        if(node.schema !is null)
        {
            _buffer ~= node.schema ~ ".";
        }

        _buffer ~= node.name;
    }

    void visit(TernaryNode node)
    {
        node.first.accept(this);
        node.second.accept(this);
        node.third.accept(this);
    }

    void visit(UnaryNode node)
    {
        _buffer ~= node.operator ~ " ";
        node.operand.accept(this);
    }

    void visit(WhereNode node)
    {
        _buffer ~= " WHERE ";
        node.clause.accept(this);
    }
}

@property
auto squish(string input)
{
    import std.string, std.regex : ctRegex, replaceAll;
    return input.strip.replaceAll(ctRegex!(r"\s+"), " ");
}
