package wygl.run;
/**
 * <p>管理楼盘的类，包括楼盘的修改、查询，删除，添加 </p>
 */
import java.sql.*;
import java.util.Vector;
import wygl.util.*;
import wygl.op.*;
import javax.servlet.http.HttpServletRequest;
import wygl.util.QueryPage;

public class op_build extends DataBase{
  private build abuilds = new build();	                           //新的楼盘类
        private javax.servlet.http.HttpServletRequest request; //建立页面请求
        private boolean sqlflag = true ;		               //对接收到的数据是否正确
        private Vector buildlist;			                   //显示楼盘列表向量数组
        private int page = 1;				                   //显示的页码
        private int pageSize=15;				               //每页显示的记录数
        private int pageCount =0;				               //页面总数
        private int recordCount =0;			                   //查询的记录总数
        public String sqlStr="";
        public Vector getbuildlist() {
                return buildlist;
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
   abuilds.setId(lvdid);

   String buildnum = request.getParameter("buildnum");
   if (buildnum==null || buildnum.equals("")){buildnum = "";sqlflag = false;}
   abuilds.setbuildnum(to_String(buildnum));

   String name = request.getParameter("name");
   if (name==null || name.equals(""))   {  name = "";sqlflag = false; }
   abuilds.setname(to_String(name));

   String addr = request.getParameter("addr");;
   if (addr==null) {      addr = "";  }
   abuilds.setaddr(to_String(addr));
   
   String info = request.getParameter("info");
   if (info == null) {        info = "";   }
   abuilds.setinfo(to_String(info));

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
* 获得查询楼盘类别的sql语句
* @return
*/
public String getSql() {
   sqlStr = "select id,buildnum,name from dbo.build order by id desc";
   return sqlStr;
        }


/**
* 查询所有楼盘
* @return
* @throws java.lang.Exception
*/
  public boolean seachallbuild() throws Exception {
                  int id = 0;
                  String buildnum = "";
				  String name = "";	
				 
                  int rscount = 0;
                  try {
                  DataBase db = new DataBase();
                  db.connect();
                  stmt = db.conn.createStatement ();
                  rs = stmt.executeQuery(getSql());
                  rscount = stmt.getMaxRows();
                  buildlist = new Vector(rscount+1);
                  buildlist.clear();
                  while (rs.next()){
                                  id = rs.getInt("id");
                                  buildnum = rs.getString("buildnum");
								  name = rs.getString("name");
								  
								  build bc = new build(id,buildnum,name);
                                  buildlist.addElement(bc);
								  
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
* 完成楼盘查询，包括分类，分页查询
* @param res
* @return
* @throws java.lang.Exception
*/
public boolean build_search(HttpServletRequest res) throws Exception {
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

 String sqlStr = "select count(*) from dbo.build where 1=1"; 

if(!keyword1.equals("")){
    sqlStr += " and name= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and addr= '"+keyword2+ "'";
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
sqlStr="select * from dbo.build a where 1=1" ;


if(!keyword1.equals("")){
    sqlStr += " and name= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and addr= '"+keyword2+ "'";
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
		     buildlist = new Vector(recordCount);
			 int i=0;
              while (rs.next() && i<pageSize){
                                build build = new build();
                                build.setId(rs.getLong("id"));
                                build.setbuildnum(rs.getString("buildnum"));
								build.setname(rs.getString("name"));
								build.setaddr(rs.getString("addr"));
                                build.setinfo(rs.getString("info"));
															                               
                                buildlist.addElement(build);
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
* 完成楼盘添加
* @return
* @throws java.lang.Exception
*/
 public boolean insert() throws Exception {
  sqlStr = "insert into dbo.build (buildnum,name,addr,info) values ('";
           sqlStr = sqlStr + dataFormat.toSql(abuilds.getbuildnum()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(abuilds.getname()) + "','";
           sqlStr = sqlStr + dataFormat.toSql(abuilds.getaddr()) + "','";         
           sqlStr = sqlStr + dataFormat.toSql(abuilds.getinfo())+"')";
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
* 完成楼盘修改
* @return
* @throws java.lang.Exception
*/
public boolean update() throws Exception {
  sqlStr = "update dbo.build set ";
  sqlStr = sqlStr + "buildnum = '" + dataFormat.toSql(abuilds.getbuildnum()) + "',";
  sqlStr = sqlStr + "name = '" + dataFormat.toSql(abuilds.getname()) + "',";
  sqlStr = sqlStr + "addr = '" + dataFormat.toSql(abuilds.getaddr()) + "',"; 
  sqlStr = sqlStr + "info = '" + dataFormat.toSql(abuilds.getinfo()) + "' ";
  sqlStr = sqlStr + "where id = " + abuilds.getId();
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
* 完成楼盘删除
* @param aid
* @return
* @throws java.lang.Exception
*/
public boolean delete( int aid ) throws Exception {
                sqlStr = "delete from dbo.build where id = "  + aid ;
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
* 完成楼盘单记录查询，用于支持页面的查看楼盘详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnebuild(int newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.buildnum,a.name,a.addr,"+
        "a.info from dbo.build a where a.Id = " + newid ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	buildlist = new Vector(1);
							build build = new build();
							build.setId(rs.getLong("id"));
							build.setbuildnum(rs.getString("buildnum"));
							build.setname(rs.getString("name"));
							build.setaddr(rs.getString("addr"));
							build.setinfo(rs.getString("info"));
							buildlist.addElement(build);
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
* 完成楼盘单记录查询，用于支持页面的查看楼盘详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnebuild1(String newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.buildnum,a.name,a.addr,"+
        "a.info from dbo.build a where a.buildnum = '" + newid+"'" ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	buildlist = new Vector(1);
							build build = new build();
							build.setId(rs.getLong("id"));
							build.setbuildnum(rs.getString("buildnum"));
							build.setaddr(rs.getString("addr"));
							build.setname(rs.getString("name"));
							
							build.setinfo(rs.getString("info"));
							
							buildlist.addElement(build);
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
        public int getPageSize(){			    //每页显示的楼盘数
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
        
  public op_build() {
       }
}