
module sqld.ast.over_node;

import sqld.ast.column_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;
import sqld.ast.window_definition_node;
import sqld.window_builder;

class OverNode : ExpressionNode
{
    mixin Visitable;

private:
    ExpressionNode _subject;
    ExpressionNode _window;

public:
    this(immutable(ExpressionNode) subject, immutable(ExpressionNode) window = null) immutable
    {
        _subject = subject;
        _window  = window;
    }

    @property
    immutable(ExpressionNode) subject() immutable
    {
        return _subject;
    }

    @property
    immutable(ExpressionNode) window() immutable
    {
        return _window;
    }
}

immutable(OverNode) over(immutable(ExpressionNode) subject, string name)
{
    return new immutable OverNode(subject, new immutable ColumnNode(name));
}

immutable(OverNode) over(immutable(ExpressionNode) subject, immutable(WindowDefinitionNode) window = null)
{
    return new immutable OverNode(subject, window);
}

immutable(OverNode) over(immutable(ExpressionNode) subject, WindowBuilder delegate(WindowBuilder) callback)
{
    return new immutable OverNode(subject, callback(WindowBuilder.init).build);
}
