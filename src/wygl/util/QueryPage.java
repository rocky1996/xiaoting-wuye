package wygl.util;

import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;



public class QueryPage
{

    public QueryPage()
    {
        dbconn = new DataBase();
    }

    public ResultSet getPageof(String s, String s1, int i, int j)
    {
        int k = Integer.parseInt(s1);
        if(j == 0)
            return null;
        int l = ((j + i) - 1) / i;
        if(k > l)
            k = l;
        ResultSet resultset = dbconn.execQuery(s);
        int i1 = (k - 1) * i;
        try
        {
            for(int j1 = 0; j1 < i1; j1++)
                resultset.next();

        }
        catch(SQLException sqlexception)
        {
            System.err.println("QueryPage.getPageof()" + sqlexception.getMessage());
        }
        return resultset;
    }

    private DataBase dbconn;
}
