package wygl.util;
import java.sql.*;
public class DataBase {
  public Connection conn;
  public Statement stmt;
  public ResultSet rs=null;
  public String sqlStr="";

  public DataBase() {
    this.connect();
  }
 public boolean connect(){
      try{
		//access数据库
        //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver").newInstance();
        //String url ="jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=D:/workspace/wygl/WebRoot/database/wygl_database.mdb";
        //conn=DriverManager.getConnection(url,"root","wygl8888");
		//ODBC数据库(odbc)
        //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        //String url ="jdbc:odbc:wygl";
        //conn=DriverManager.getConnection(url,"root","wygl8888");
		//sql 2000数据库
		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver").newInstance(); 
        String url="jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=wygl_database"; 
		conn=DriverManager.getConnection(url,"sa","123456wjf");
		//MySQL数据库
		//Class.forName("com.mysql.jdbc.Driver").newInstance();
		//String url ="jdbc:mysql://localhost:3306/wygl_database";
        //conn=DriverManager.getConnection(url,"root","111111");
        stmt = conn.createStatement ();
       }catch(Exception ee){
        System.out.println("connect db error:"+ee.getMessage());
        return false;
       }
      return true;
    }

//用于执行查询数据库的操作
//返回查询结果集
	public  ResultSet execQuery(String sql) {
		//access数据库
		//String url ="jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=D:/workspace/wygl/WebRoot/database/wygl_database.mdb";
		//ODBC数据库(ODBC)
		//String url ="jdbc:odbc:wygl";
		//sql2000数据库
		String url="jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=wygl_database"; 
		//MySql数据库
		//String url ="jdbc:mysql://localhost:3306/wygl_database";
		ResultSet rs=null;
		try {
            //access数据库
			//conn = DriverManager.getConnection(url,"root","wygl8888");
			//sqlserver数据库
		    conn=DriverManager.getConnection(url,"sa","123456wjf"); 
			//mysql数据库
		    //conn=DriverManager.getConnection(url,"root","111111");  
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
		} catch(SQLException ex) {
			System.err.println("DataBase.execQuery(): " + ex.getMessage());
		}

		return rs;
	}

//sql执行
public void execute(String sql){
	    //Access数据库
		//String url ="jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=D:/workspace/wygl/WebRoot/database/wygl_database.mdb";
		//ODBC数据库(ODBC)
		//String url ="jdbc:odbc:wygl";
		//sql2000数据库
		String url="jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=wygl_database"; 
        //MySQL数据库
	    //String url ="jdbc:mysql://localhost:3306/wygl_database";
	try{
		     //Access数据库 or ODBC数据源
			 //conn = DriverManager.getConnection(url,"root","wygl8888");
            //MySQL数据库
		    //conn=DriverManager.getConnection(url,"root","111111"); 
			//Sql2000数据库
			conn=DriverManager.getConnection(url,"sa","123456wjf");
		Statement stmt = conn.createStatement();
        stmt.execute(sql);

	}catch(SQLException e){
		e.printStackTrace();
	}
}

public void closeStmt(){
	try{
		stmt.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
}


public void closeConn(){
	try{
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
}

}