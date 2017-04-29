
module sqld;

public import sqld.ast;
public import sqld.delete_builder;
public import sqld.insert_builder;
public import sqld.select_builder;
public import sqld.update_builder;
public import sqld.window_builder;

struct SQLD
{
    static DeleteBuilder delete_()
    {
        return DeleteBuilder.init;
    }

    static InsertBuilder insert()
    {
        return InsertBuilder.init;
    }

    static SelectBuilder select()
    {
        return SelectBuilder.init;
    }

    static SelectBuilder select(TList...)(TList args) if(TList.length > 0)
    {
        return SelectBuilder.init.select(args);
    }

    static UpdateBuilder update()
    {
        return UpdateBuilder.init;
    }

    static UpdateBuilder update(TList...)(TList args) if(TList.length > 0)
    {
        return UpdateBuilder.init.update(args);
    }

    static WindowBuilder window()
    {
        return WindowBuilder.init;
    }
}
