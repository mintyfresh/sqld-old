
module sqld.ast.arithmetic_node;

import sqld.ast.binary_node;
import sqld.ast.expression_node;
import sqld.ast.visitor;

enum ArithmeticOperator : string
{
    plus       = "+",
    minus      = "-",
    times      = "*",
    divide     = "/",
    modulo     = "%",
    bitAnd     = "&",
    bitOr      = "|",
    bitXor     = "^",
    shiftLeft  = "<<",
    shiftRight = ">>"
}

immutable class ArithmeticNode : BinaryNode
{
    mixin Visitable;

private:
    ArithmeticOperator _operator;

public:
    this(immutable(ExpressionNode) left, ArithmeticOperator operator, immutable(ExpressionNode) right)
    {
        super(left, right);
        _operator = operator;
    }

    @property
    ArithmeticOperator operator()
    {
        return _operator;
    }
}
