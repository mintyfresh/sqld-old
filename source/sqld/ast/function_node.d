
module sqld.ast.function_node;

import sqld.ast.expression_node;
import sqld.ast.visitor;

enum FunctionName : string
{
    avg   = "AVG",
    count = "COUNT",
    max   = "MAX",
    min   = "MIN",
    sum   = "SUM"
}

class FunctionNode : ExpressionNode
{
    mixin Visitable;

private:
    string _name;

public:
    this(string name) immutable
    {
        _name = name;
    }

    @property
    string name() immutable
    {
        return _name;
    }
}
