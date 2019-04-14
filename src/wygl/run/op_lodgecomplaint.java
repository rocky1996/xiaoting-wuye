package wygl.run;
/**
 * <p>管理投诉的类，包括投诉的修改、查询，删除，添加 </p>
 */
import java.sql.*;
import java.util.Vector;
import wygl.util.*;
import wygl.op.*;
import javax.servlet.http.HttpServletRequest;
import wygl.util.QueryPage;

public class op_lodgecomplaint extends DataBase{
  private lodgecomplaint alodgecomplaints = new lodgecomplaint();	                           //新的投诉类
        private javax.servlet.http.HttpServletRequest request; //建立页面请求
        private boolean sqlflag = true ;		               //对接收到的数据是否正确
        private Vector lodgecomplaintlist;			                   //显示投诉列表向量数组
        private int page = 1;				                   //显示的页码
        private int pageSize=15;				               //每页显示的记录数
        private int pageCount =0;				               //页面总数
        private int recordCount =0;			                   //查询的记录总数
        public String sqlStr="";
        public Vector getlodgecomplaintlist() {
                return lodgecomplaintlist;
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
   alodgecomplaints.setId(lvdid);

   String buildnum = request.getParameter("buildnum");
   if (buildnum==null || buildnum.equals("")){buildnum = "";sqlflag = false;}
   alodgecomplaints.setbuildnum(to_String(buildnum));

   String cellnum = request.getParameter("cellnum");
   if (cellnum==null || cellnum.equals(""))   {  cellnum = "";sqlflag = false; }
   alodgecomplaints.setcellnum(to_String(cellnum));

   String roomnum = request.getParameter("roomnum");;
   if (roomnum==null) {      roomnum = "";  }
   alodgecomplaints.setroomnum(to_String(roomnum));

   String lodgeusername = request.getParameter("lodgeusername");;
   if (lodgeusername==null) {      lodgeusername = "";  }
   alodgecomplaints.setlodgeusername(to_String(lodgeusername));
   
   String reason = request.getParameter("reason");
   if (reason == null) {        reason = "";   }
   alodgecomplaints.setreason(to_String(reason));

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
* 获得查询投诉类别的sql语句
* @return
*/
public String getSql() {
   sqlStr = "select id,buildnum,lodgeusername from dbo.lodgecomplaint order by id desc";
   return sqlStr;
        }


/**
* 查询所有投诉
* @return
* @throws java.lang.Exception
*/
  public boolean seachalllodgecomplaint() throws Exception {
                  int id = 0;
                  String buildnum = "";
				  String lodgeusername = "";	
				 
                  int rscount = 0;
                  try {
                  DataBase db = new DataBase();
                  db.connect();
                  stmt = db.conn.createStatement ();
                  rs = stmt.executeQuery(getSql());
                  rscount = stmt.getMaxRows();
                  lodgecomplaintlist = new Vector(rscount+1);
                  lodgecomplaintlist.clear();
                  while (rs.next()){
                                  id = rs.getInt("id");
                                  buildnum = rs.getString("buildnum");
								  lodgeusername = rs.getString("lodgeusername");
								  
								  lodgecomplaint bc = new lodgecomplaint(id,buildnum,lodgeusername);
                                  lodgecomplaintlist.addElement(bc);
								  
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
* 完成投诉查询，包括分类，分页查询
* @param res
* @return
* @throws java.lang.Exception
*/
public boolean lodgecomplaint_search(HttpServletRequest res) throws Exception {
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

 String sqlStr = "select count(*) from dbo.lodgecomplaint where 1=1"; 

if(!keyword1.equals("")){
    sqlStr += " and buildnum= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and lodgeusername= '"+keyword2+ "'";
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
sqlStr="select  * from dbo.lodgecomplaint a where 1=1" ;


if(!keyword1.equals("")){
    sqlStr += " and buildnum= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and lodgeusername= '"+keyword2+ "'";
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
		     lodgecomplaintlist = new Vector(recordCount);
			 int i=0;
              while (rs.next() && i<pageSize){
                                lodgecomplaint lodgecomplaint = new lodgecomplaint();
                                lodgecomplaint.setId(rs.getLong("id"));
                                lodgecomplaint.setbuildnum(rs.getString("buildnum"));
								lodgecomplaint.setcellnum(rs.getString("cellnum"));
								lodgecomplaint.setroomnum(rs.getString("roomnum"));
								lodgecomplaint.setlodgeusername(rs.getString("lodgeusername"));
                                lodgecomplaint.setreason(rs.getString("reason"));
															                               
                                lodgecomplaintlist.addElement(lodgecomplaint);
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
* 完成投诉添加
* @return
* @throws java.lang.Exception
*/
 public boolean insert() throws Exception {
  sqlStr = "insert into dbo.lodgecomplaint (buildnum,cellnum,roomnum,lodgeusername,reason) values ('";
           sqlStr = sqlStr + dataFormat.toSql(alodgecomplaints.getbuildnum()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(alodgecomplaints.getcellnum()) + "','";
           sqlStr = sqlStr + dataFormat.toSql(alodgecomplaints.getroomnum()) + "','";  
		   sqlStr = sqlStr + dataFormat.toSql(alodgecomplaints.getlodgeusername()) + "','"; 
           sqlStr = sqlStr + dataFormat.toSql(alodgecomplaints.getreason())+"')";
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
* 完成投诉修改
* @return
* @throws java.lang.Exception
*/
public boolean update() throws Exception {
  sqlStr = "update dbo.lodgecomplaint set ";
  sqlStr = sqlStr + "buildnum = '" + dataFormat.toSql(alodgecomplaints.getbuildnum()) + "',";
  sqlStr = sqlStr + "cellnum = '" + dataFormat.toSql(alodgecomplaints.getcellnum()) + "',";
  sqlStr = sqlStr + "roomnum = '" + dataFormat.toSql(alodgecomplaints.getroomnum()) + "',"; 
  sqlStr = sqlStr + "lodgeusername = '" + dataFormat.toSql(alodgecomplaints.getlodgeusername()) + "',"; 
  sqlStr = sqlStr + "reason = '" + dataFormat.toSql(alodgecomplaints.getreason()) + "' ";
  sqlStr = sqlStr + "where id = " + alodgecomplaints.getId();
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
* 完成投诉删除
* @param aid
* @return
* @throws java.lang.Exception
*/
public boolean delete( int aid ) throws Exception {
                sqlStr = "delete from dbo.lodgecomplaint where id = "  + aid ;
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
* 完成投诉单记录查询，用于支持页面的查看投诉详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnelodgecomplaint(int newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.buildnum,a.cellnum,a.roomnum,"+
        "a.lodgeusername,a.reason from dbo.lodgecomplaint a where a.Id = " + newid ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	lodgecomplaintlist = new Vector(1);
							lodgecomplaint lodgecomplaint = new lodgecomplaint();
							lodgecomplaint.setId(rs.getLong("id"));
							lodgecomplaint.setbuildnum(rs.getString("buildnum"));
							lodgecomplaint.setcellnum(rs.getString("cellnum"));
							lodgecomplaint.setroomnum(rs.getString("roomnum"));
							lodgecomplaint.setlodgeusername(rs.getString("lodgeusername"));
							lodgecomplaint.setreason(rs.getString("reason"));
							lodgecomplaintlist.addElement(lodgecomplaint);
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
* 完成投诉单记录查询，用于支持页面的查看投诉详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnelodgecomplaint1(String newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.buildnum,a.cellnum,a.roomnum,"+
        "a.lodgeusername,a.reason from dbo.lodgecomplaint a where a.buildnum = '" + newid+"'" ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	lodgecomplaintlist = new Vector(1);
							lodgecomplaint lodgecomplaint = new lodgecomplaint();
							lodgecomplaint.setId(rs.getLong("id"));
							lodgecomplaint.setbuildnum(rs.getString("buildnum"));
							lodgecomplaint.setcellnum(rs.getString("cellnum"));
							lodgecomplaint.setroomnum(rs.getString("roomnum"));
							lodgecomplaint.setlodgeusername(rs.getString("lodgeusername"));
							lodgecomplaint.setreason(rs.getString("reason"));
							
							lodgecomplaintlist.addElement(lodgecomplaint);
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
        public int getPageSize(){			    //每页显示的投诉数
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
        
  public op_lodgecomplaint() {
       }
}