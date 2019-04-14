package wygl.run;
/**
 * <p>管理小区公告的类，包括小区公告的修改、查询，删除，添加 </p>
 */
import java.sql.*;
import java.util.Vector;
import wygl.util.*;
import wygl.op.*;
import javax.servlet.http.HttpServletRequest;
import wygl.util.QueryPage;

public class op_news extends DataBase{
  private news anewss = new news();	                           //新的小区公告类
        private javax.servlet.http.HttpServletRequest request; //建立页面请求
        private boolean sqlflag = true ;		               //对接收到的数据是否正确
        private Vector newslist;			                   //显示小区公告列表向量数组
        private int page = 1;				                   //显示的页码
        private int pageSize=15;				               //每页显示的记录数
        private int pageCount =0;				               //页面总数
        private int recordCount =0;			                   //查询的记录总数
        public String sqlStr="";
        public Vector getnewslist() {
                return newslist;
        }
        public boolean getSqlflag() {
                return sqlflag;
        }
        public String to_String( String str) {
                try
                {
                        return new String(str.getBytes("ISO8859-1"));
                }
                catch (Exception e)
                {
                        return str;
                }
        }
/**
* 将页面表单传来的资料分解
*/
public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
  boolean flag = false;
  try{
   request = newrequest;
   String ID = request.getParameter("id");
   long lvdid = 0;
   try{
           lvdid = Long.parseLong(ID);
   }catch (Exception e){
   }
   anewss.setId(lvdid);

   String title = request.getParameter("title");
   if (title==null || title.equals("")){title = "";sqlflag = false;}
   anewss.settitle(to_String(title));

   String contant = request.getParameter("contant");
   if (contant==null || contant.equals(""))   {  contant = "";sqlflag = false; }
   anewss.setcontant(to_String(contant));

   String senddate = request.getParameter("senddate");;
   if (senddate==null) {      senddate = "";  }
   anewss.setsenddate(to_String(senddate));

   
   if (sqlflag)
   {
           flag = true;
   }
   return flag;
                }catch (Exception e){
   return flag;
                }
        }
/**
* 获得查询小区公告类别的sql语句
* @return
*/
public String getSql() {
   sqlStr = "select id,title from dbo.news order by id desc";
   return sqlStr;
        }


/**
* 查询所有小区公告
* @return
* @throws java.lang.Exception
*/
  public boolean seachallnews() throws Exception {
                  int id = 0;
                  String title = "";
				  				 
                  int rscount = 0;
                  try {
                  DataBase db = new DataBase();
                  db.connect();
                  stmt = db.conn.createStatement ();
                  rs = stmt.executeQuery(getSql());
                  rscount = stmt.getMaxRows();
                  newslist = new Vector(rscount+1);
                  newslist.clear();
                  while (rs.next()){
                                  id = rs.getInt("id");
                                  title = rs.getString("title");
								  
								  
								  news bc = new news(id,title);
                                  newslist.addElement(bc);
								  
                          }
                          rs.close();
						 db.closeStmt();
						  db.closeConn();
                          return true;
                  }
                  catch (SQLException sqle){
                          System.out.println(sqle);
              return false;
                  }
          }





/**
* 完成小区公告查询，包括分类，分页查询
* @param res
* @return
* @throws java.lang.Exception
*/
public boolean news_search(HttpServletRequest res) throws Exception {
    DataBase db = new DataBase();
   db.connect();
   stmt = db.conn.createStatement ();
   request = res;
   String PAGE = request.getParameter("page");   //页码
    
   String keyword1 = request.getParameter("keyword1");	    //查询关键词1   
   if (keyword1==null) keyword1 = "";
   keyword1 = to_String(keyword1).toUpperCase(); 

   String keyword2 = request.getParameter("keyword2");	    //查询关键词2
   if (keyword2==null) keyword2 = "";
   keyword2 = to_String(keyword2).toUpperCase(); 

   try {
           page = Integer.parseInt(PAGE);
   }catch (NumberFormatException e){
           page = 1;
		   PAGE ="1";
   }

 String sqlStr = "select count(*) from dbo.news where 1=1"; 

if(!keyword1.equals("")){
    sqlStr += " and title= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and senddate= '"+keyword2+ "'";
}

  
   try {
           ResultSet rs1 = stmt.executeQuery(sqlStr);
           if (rs1.next()) recordCount = rs1.getInt(1);
           rs1.close();
		  db.closeStmt();
						  db.closeConn();
   }catch (SQLException e){
           System.out.println(e.getMessage());
           return false;
   }
sqlStr="select  * from dbo.news a where 1=1" ;


if(!keyword1.equals("")){
    sqlStr += " and title= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and senddate= '"+keyword2+ "'";
} 


if(recordCount < pageSize){
			 pageCount=1;
		 }else{
			 pageCount=(int)(recordCount - 1) / pageSize + 1; 			
         }

sqlStr=sqlStr+" order by id desc";



   

        try  {
			 QueryPage fy = new QueryPage();
			 rs =fy.getPageof(sqlStr, PAGE, pageSize,recordCount);
		     newslist = new Vector(recordCount);
			 int i=0;
              while (rs.next() && i<pageSize){
                                news news = new news();
                                news.setId(rs.getLong("id"));
                                news.settitle(rs.getString("title"));
								news.setcontant(rs.getString("contant"));
								news.setsenddate(rs.getString("senddate"));
																						                               
                                newslist.addElement(news);
								i++;
                        }
                        rs.close();
					  db.closeStmt();
						  db.closeConn();
                        return true;

                }catch (Exception e){
                        System.out.println(e.getMessage());
                        return false;
                }
        }
/**
* 完成小区公告添加
* @return
* @throws java.lang.Exception
*/
 public boolean insert() throws Exception {
  sqlStr = "insert into dbo.news (title,contant,senddate) values ('";
           sqlStr = sqlStr + dataFormat.toSql(anewss.gettitle()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(anewss.getcontant()) + "','";
           sqlStr = sqlStr + dataFormat.toSql(anewss.getsenddate()) + "')";   
		       try{
                        System.out.print(sqlStr);
                        DataBase db = new DataBase();
                        db.connect();
                        stmt =db.conn.createStatement ();
                        stmt.execute(sqlStr);
						db.closeStmt();
						  db.closeConn();
                        return true;
                }catch (SQLException sqle){
                  System.out.print(sqle.getMessage());
                        return false;
                }
        } 
/**
* 完成小区公告修改
* @return
* @throws java.lang.Exception
*/
public boolean update() throws Exception {
  sqlStr = "update dbo.news set ";
  sqlStr = sqlStr + "title = '" + dataFormat.toSql(anewss.gettitle()) + "',";
  sqlStr = sqlStr + "contant = '" + dataFormat.toSql(anewss.getcontant()) + "',";
  sqlStr = sqlStr + "senddate = '" + dataFormat.toSql(anewss.getsenddate()) + "' "; 
  sqlStr = sqlStr + "where id = " + anewss.getId();
                try{
                        DataBase db = new DataBase();
                        db.connect();
                        stmt =db.conn.createStatement ();
                        stmt.execute(sqlStr);
						db.closeStmt();
						  db.closeConn();
                        return true;
                } catch (SQLException e){
                        System.out.print(e.getMessage());
                        return false;
                }

        }
/**
* 完成小区公告删除
* @param aid
* @return
* @throws java.lang.Exception
*/
public boolean delete( int aid ) throws Exception {
                sqlStr = "delete from dbo.news where id = "  + aid ;
                try
                {         DataBase db = new DataBase();
                          db.connect();
                          stmt =db.conn.createStatement ();
                          stmt.execute(sqlStr);
						 db.closeStmt();
						  db.closeConn();
                         return true;
                }
                catch (SQLException e)
                {
                        System.out.println(e);
                        return false;
                }
              }
/**
* 完成小区公告单记录查询，用于支持页面的查看小区公告详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnenews(int newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.title,a.contant,a.senddate"+
        " from dbo.news a where a.Id = " + newid ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	newslist = new Vector(1);
							news news = new news();
							news.setId(rs.getLong("id"));
							news.settitle(rs.getString("title"));
							news.setcontant(rs.getString("contant"));
							news.setsenddate(rs.getString("senddate"));
							newslist.addElement(news);
							rs.close();
						db.closeStmt();
						  db.closeConn();
                        return true;
                        } else {
                                rs.close();
								db.closeStmt();
						  db.closeConn();
                                return false;
                        }
                        
                }
                catch (SQLException e)
                {
                        return false;
                }
        }

/**
* 完成小区公告单记录查询，用于支持页面的查看小区公告详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnenews1(String newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.title,a.contant,a.senddate"+
        " from dbo.news a where a.title = '" + newid+"'" ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	newslist = new Vector(1);
							news news = new news();
							news.setId(rs.getLong("id"));
							news.settitle(rs.getString("title"));
							news.setsenddate(rs.getString("senddate"));
												
							newslist.addElement(news);
							  rs.close();
						db.closeStmt();
						  db.closeConn();
                        return true;
                        } else {
                                rs.close();
								db.closeStmt();
						  db.closeConn();
                                return false;
                        }
                      
                }
                catch (SQLException e)
                {
                        return false;
                }
        }

        public int getPage() {				    //显示的页码
                return page;
        }
        public void setPage(int newpage) {
                page = newpage;
        }
        public int getPageSize(){			    //每页显示的小区公告数
                return pageSize;
        }
        public void setPageSize(int newpsize) {
                pageSize = newpsize;
        }
        public int getPageCount() {				//页面总数
                return pageCount;
        }
        public void setPageCount(int newpcount) {
                pageCount = newpcount;
        }
        public int getrecordCount() {            //记录总数
                return recordCount;
        }
        
  public op_news() {
       }
}