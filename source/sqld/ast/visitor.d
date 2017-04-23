
module sqld.ast.visitor;

import sqld.ast;

interface Visitor
{
    void visit(const(AsNode) node);

    void visit(const(BinaryNode) node);

    void visit(const(ColumnNode) node);

    void visit(const(DirectionNode) node);

    void visit(const(ExpressionListNode) node);

    void visit(const(ExpressionNode) node);

    void visit(const(FromNode) node);

    void visit(const(FunctionNode) node);

    void visit(const(GroupByNode) node);

    void visit(const(HavingNode) node);

    void visit(const(InvocationNode) node);

    void visit(const(JoinNode) node);

    void visit(const(LimitNode) node);

    void visit(const(LiteralNode) node);

    void visit(const(Node) node);

    void visit(const(OffsetNode) node);

    void visit(const(OrderByNode) node);

    void visit(const(ProjectionNode) node);

    void visit(const(QueryNode) node);

    void visit(const(SelectNode) node);

    void visit(const(SubqueryNode) node);

    void visit(const(SQLNode) node);

    void visit(const(TableNode) node);

    void visit(const(TernaryNode) node);

    void visit(const(UnaryNode) node);

    void visit(const(WhereNode) node);
}

mixin template Visitable()
{
    override void accept(Visitor visitor) const
    {
        visitor.visit(this);
    }
}
