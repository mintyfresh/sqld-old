
module sqld.ast.node;

import sqld.ast.visitor;

/++
 + The base class for all SQLD AST nodes.
 +/
immutable abstract class Node
{
    /++
     + A base implementation of the accept function for the AST-Visitor API.
     + Deriving classes that produce AST output must override this function.
     +
     + Params:
     +   Visitor - A Visitor instance that traverses the AST and produces SQL output.
     +/
    abstract void accept(Visitor)
    {
        assert(0, "Attempt to visit Node. (" ~ this.classinfo.name ~ ")");
    }
}

/++
 + A helper that accepts an AST node an produces a SQL string for a given Visitor implementation.
 +
 + Params:
 +   T    - The Visitor Type that's used for query generation.
 +   node - A node representing the root of the AST, from which SQL generation beings.
 +
 + Returns:
 +   The SQL string produced by the AST-Visitor.
 +/
@property
string toSQL(T)(immutable(Node) node) if(is(T : Visitor))
{
    auto visitor = new T;
    node.accept(visitor);

    return visitor.sql;
}
