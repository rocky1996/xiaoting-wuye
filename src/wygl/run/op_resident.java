package wygl.run;
/**
 * <p>管理住户的类，包括住户的修改、查询，删除，添加 </p>
 */
import java.sql.*;
import java.util.Vector;
import wygl.util.*;
import wygl.op.*;
import javax.servlet.http.HttpServletRequest;
import wygl.util.QueryPage;

public class op_resident extends DataBase{
  private resident aresidents = new resident();	                           //新的住户类
        private javax.servlet.http.HttpServletRequest request; //建立页面请求
        private boolean sqlflag = true ;		               //对接收到的数据是否正确
        private Vector residentlist;			                   //显示住户列表向量数组
        private int page = 1;				                   //显示的页码
        private int pageSize=15;				               //每页显示的记录数
        private int pageCount =0;				               //页面总数
        private int recordCount =0;			                   //查询的记录总数
        public String sqlStr="";
        public Vector getresidentlist() {
                return residentlist;
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
   aresidents.setId(lvdid);

   String residentnum = request.getParameter("residentnum");
   if (residentnum==null || residentnum.equals("")){residentnum = "";sqlflag = false;}
   aresidents.setresidentnum(to_String(residentnum));

   String name = request.getParameter("name");
   if (name==null || name.equals(""))   {  name = "";sqlflag = false; }
   aresidents.setname(to_String(name));

   String buildnum = request.getParameter("buildnum");;
   if (buildnum==null) {      buildnum = "";  }
   aresidents.setbuildnum(to_String(buildnum));
   
   String cellnum = request.getParameter("cellnum");
   if (cellnum == null) {        cellnum = "";   }
   aresidents.setcellnum(to_String(cellnum));

   String roomnum = request.getParameter("roomnum");
   if (roomnum == null) {        roomnum = "";   }
   aresidents.setroomnum(to_String(roomnum));

   String area = request.getParameter("area");
   if (area == null) {        area = "";   }
   aresidents.setarea(to_String(area));

   String otherinfo = request.getParameter("otherinfo");
   if (otherinfo == null) {        otherinfo = "";   }
   aresidents.setotherinfo(to_String(otherinfo));

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
* 获得查询住户类别的sql语句
* @return
*/
public String getSql() {
   sqlStr = "select id,residentnum,name from dbo.resident order by id desc";
   return sqlStr;
        }


/**
* 查询所有住户
* @return
* @throws java.lang.Exception
*/
  public boolean seachallresident() throws Exception {
                  int id = 0;
                  String residentnum = "";
				  String name = "";	
				 
                  int rscount = 0;
                  try {
                  DataBase db = new DataBase();
                  db.connect();
                  stmt = db.conn.createStatement ();
                  rs = stmt.executeQuery(getSql());
                  rscount = stmt.getMaxRows();
                  residentlist = new Vector(rscount+1);
                  residentlist.clear();
                  while (rs.next()){
                                  id = rs.getInt("id");
                                  residentnum = rs.getString("residentnum");
								  name = rs.getString("name");
								  
								  resident bc = new resident(id,residentnum,name);
                                  residentlist.addElement(bc);
								  
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
* 完成住户查询，包括分类，分页查询
* @param res
* @return
* @throws java.lang.Exception
*/
public boolean resident_search(HttpServletRequest res) throws Exception {
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

 String sqlStr = "select count(*) from dbo.resident where 1=1"; 

if(!keyword1.equals("")){
    sqlStr += " and name= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and buildnum= '"+keyword2+ "'";
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
sqlStr="select  * from dbo.resident a where 1=1" ;


if(!keyword1.equals("")){
    sqlStr += " and name= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and buildnum= '"+keyword2+ "'";
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
		     residentlist = new Vector(recordCount);
			 int i=0;
              while (rs.next() && i<pageSize){
                                resident resident = new resident();
                                resident.setId(rs.getLong("id"));
                                resident.setresidentnum(rs.getString("residentnum"));
								resident.setname(rs.getString("name"));
								resident.setbuildnum(rs.getString("buildnum"));
                                resident.setcellnum(rs.getString("cellnum"));
								 resident.setroomnum(rs.getString("roomnum"));
								  resident.setarea(rs.getString("area"));
								   resident.setotherinfo(rs.getString("otherinfo"));
															                               
                                residentlist.addElement(resident);
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
* 完成住户添加
* @return
* @throws java.lang.Exception
*/
 public boolean insert() throws Exception {
  sqlStr = "insert into dbo.resident (residentnum,name,buildnum,cellnum,roomnum,area,otherinfo) values ('";
           sqlStr = sqlStr + dataFormat.toSql(aresidents.getresidentnum()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(aresidents.getname()) + "','";
           sqlStr = sqlStr + dataFormat.toSql(aresidents.getbuildnum()) + "','";   
		   sqlStr = sqlStr + dataFormat.toSql(aresidents.getcellnum()) + "','"; 
		   sqlStr = sqlStr + dataFormat.toSql(aresidents.getroomnum()) + "','"; 
		   sqlStr = sqlStr + dataFormat.toSql(aresidents.getarea()) + "','"; 
           sqlStr = sqlStr + dataFormat.toSql(aresidents.getotherinfo())+"')";
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
* 完成住户修改
* @return
* @throws java.lang.Exception
*/
public boolean update() throws Exception {
  sqlStr = "update dbo.resident set ";
  sqlStr = sqlStr + "residentnum = '" + dataFormat.toSql(aresidents.getresidentnum()) + "',";
  sqlStr = sqlStr + "name = '" + dataFormat.toSql(aresidents.getname()) + "',";
  sqlStr = sqlStr + "buildnum = '" + dataFormat.toSql(aresidents.getbuildnum()) + "',"; 
  sqlStr = sqlStr + "cellnum = '" + dataFormat.toSql(aresidents.getcellnum()) + "', ";
  sqlStr = sqlStr + "roomnum = '" + dataFormat.toSql(aresidents.getroomnum()) + "', ";
  sqlStr = sqlStr + "area = '" + dataFormat.toSql(aresidents.getarea()) + "', ";
  sqlStr = sqlStr + "otherinfo = '" + dataFormat.toSql(aresidents.getotherinfo()) + "' ";
  sqlStr = sqlStr + "where id = " + aresidents.getId();
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
* 完成住户删除
* @param aid
* @return
* @throws java.lang.Exception
*/
public boolean delete( int aid ) throws Exception {
                sqlStr = "delete from dbo.resident where id = "  + aid ;
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
* 完成住户单记录查询，用于支持页面的查看住户详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOneresident(int newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.residentnum,a.name,a.buildnum,"+
        "a.cellnum,a.roomnum,a.area,a.otherinfo from dbo.resident a where a.Id = " + newid ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	residentlist = new Vector(1);
							resident resident = new resident();
							resident.setId(rs.getLong("id"));
							resident.setresidentnum(rs.getString("residentnum"));
							resident.setname(rs.getString("name"));
							resident.setbuildnum(rs.getString("buildnum"));
							resident.setcellnum(rs.getString("cellnum"));
							 resident.setroomnum(rs.getString("roomnum"));
								  resident.setarea(rs.getString("area"));
								   resident.setotherinfo(rs.getString("otherinfo"));
							residentlist.addElement(resident);
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
* 完成住户单记录查询，用于支持页面的查看住户详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOneresident1(String newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.residentnum,a.name,a.buildnum,"+
        "a.cellnum,a.roomnum,a.area,a.otherinfo from dbo.resident a where a.residentnum = '" + newid+"'" ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	residentlist = new Vector(1);
							resident resident = new resident();
							resident.setId(rs.getLong("id"));
							resident.setresidentnum(rs.getString("residentnum"));
							resident.setbuildnum(rs.getString("buildnum"));
							resident.setname(rs.getString("name"));							
							resident.setcellnum(rs.getString("cellnum"));
							 resident.setroomnum(rs.getString("roomnum"));
								  resident.setarea(rs.getString("area"));
								   resident.setotherinfo(rs.getString("otherinfo"));
							
							residentlist.addElement(resident);
                        } else {
                                rs.close();
								db.closeStmt();
						  db.closeConn();
                                return false;
                        }
                        rs.close();
						db.closeStmt();
						  db.closeConn();
                        return true;
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
        public int getPageSize(){			    //每页显示的住户数
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
        
  public op_resident() {
       }
}