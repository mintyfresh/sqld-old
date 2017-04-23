
module sqld.ast.visitor;

import sqld.ast;

interface Visitor
{
    void visit(AsNode node);

    void visit(BinaryNode node);

    void visit(ColumnNode node);

    void visit(DirectionNode node);

    void visit(ExpressionListNode node);

    void visit(ExpressionNode node);

    void visit(FromNode node);

    void visit(GroupByNode node);

    void visit(HavingNode node);

    void visit(JoinNode node);

    void visit(LimitNode node);

    void visit(Node node);

    void visit(OffsetNode node);

    void visit(OrderByNode node);

    void visit(ProjectionNode node);

    void visit(QueryNode node);

    void visit(SelectNode node);

    void visit(SubqueryNode node);

    void visit(SQLNode node);

    void visit(TableNode node);

    void visit(TernaryNode node);

    void visit(UnaryNode node);

    void visit(WhereNode node);
}

mixin template Visitable()
{
    override void accept(Visitor visitor)
    {
        visitor.visit(this);
    }
}
