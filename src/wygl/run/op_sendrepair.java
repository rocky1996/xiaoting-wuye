package wygl.run;
/**
 * <p>管理物业报修的类，包括物业报修的修改、查询，删除，添加 </p>
 */
import java.sql.*;
import java.util.Vector;
import wygl.util.*;
import wygl.op.*;
import javax.servlet.http.HttpServletRequest;
import wygl.util.QueryPage;

public class op_sendrepair extends DataBase{
  private sendrepair asendrepairs = new sendrepair();	                           //新的物业报修类
        private javax.servlet.http.HttpServletRequest request; //建立页面请求
        private boolean sqlflag = true ;		               //对接收到的数据是否正确
        private Vector sendrepairlist;			                   //显示物业报修列表向量数组
        private int page = 1;				                   //显示的页码
        private int pageSize=15;				               //每页显示的记录数
        private int pageCount =0;				               //页面总数
        private int recordCount =0;			                   //查询的记录总数
        public String sqlStr="";
        public Vector getsendrepairlist() {
                return sendrepairlist;
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
   asendrepairs.setId(lvdid);

   String buildnum = request.getParameter("buildnum");
   if (buildnum==null || buildnum.equals("")){buildnum = "";sqlflag = false;}
   asendrepairs.setbuildnum(to_String(buildnum));

   String cellnum = request.getParameter("cellnum");
   if (cellnum==null || cellnum.equals(""))   {  cellnum = "";sqlflag = false; }
   asendrepairs.setcellnum(to_String(cellnum));

   String roomnum = request.getParameter("roomnum");;
   if (roomnum==null) {      roomnum = "";  }
   asendrepairs.setroomnum(to_String(roomnum));

   String repairgoods = request.getParameter("repairgoods");;
   if (repairgoods==null) {      repairgoods = "";  }
   asendrepairs.setrepairgoods(to_String(repairgoods));
   
   String repairpersonname = request.getParameter("repairpersonname");
   if (repairpersonname == null) {        repairpersonname = "";   }
   asendrepairs.setrepairpersonname(to_String(repairpersonname));

   String repairtime = request.getParameter("repairtime");
   if (repairtime == null) {        repairtime = "";   }
   asendrepairs.setrepairtime(to_String(repairtime));

   String isrepair = request.getParameter("isrepair");
   if (isrepair == null) {        isrepair = "";   }
   asendrepairs.setisrepair(to_String(isrepair));

String repairedtime = request.getParameter("repairedtime");
   if (repairedtime == null) {        repairedtime = "";   }
   asendrepairs.setrepairedtime(to_String(repairedtime));

   String isrepaired = request.getParameter("isrepaired");
   if (isrepaired == null) {        isrepaired = "";   }
   asendrepairs.setisrepaired(to_String(isrepaired));
    

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
* 获得查询物业报修类别的sql语句
* @return
*/
public String getSql() {
   sqlStr = "select id,buildnum,roomnum from dbo.sendrepair order by id desc";
   return sqlStr;
        }


/**
* 查询所有物业报修
* @return
* @throws java.lang.Exception
*/
  public boolean seachallsendrepair() throws Exception {
                  int id = 0;
                  String buildnum = "";
				  String roomnum = "";	
				 
                  int rscount = 0;
                  try {
                  DataBase db = new DataBase();
                  db.connect();
                  stmt = db.conn.createStatement ();
                  rs = stmt.executeQuery(getSql());
                  rscount = stmt.getMaxRows();
                  sendrepairlist = new Vector(rscount+1);
                  sendrepairlist.clear();
                  while (rs.next()){
                                  id = rs.getInt("id");
                                  buildnum = rs.getString("buildnum");
								  roomnum = rs.getString("roomnum");
								  
								  sendrepair bc = new sendrepair(id,buildnum,roomnum);
                                  sendrepairlist.addElement(bc);
								  
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
* 完成物业报修查询，包括分类，分页查询
* @param res
* @return
* @throws java.lang.Exception
*/
public boolean sendrepair_search(HttpServletRequest res) throws Exception {
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

    String keyword3 = request.getParameter("keyword3");	    //查询关键词2
   if (keyword3==null) keyword3 = "";
   keyword3 = to_String(keyword3).toUpperCase(); 

   try {
           page = Integer.parseInt(PAGE);
   }catch (NumberFormatException e){
           page = 1;
		   PAGE ="1";
   }

 String sqlStr = "select count(*) from dbo.sendrepair where 1=1"; 

if(!keyword1.equals("")){
    sqlStr += " and buidlnum= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and roomnum= '"+keyword2+ "'";
}
if(!keyword3.equals("")){
    sqlStr += " and isrepair= '"+keyword3+ "'";
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
sqlStr="select  * from sendrepair a where 1=1" ;


if(!keyword1.equals("")){
    sqlStr += " and buildnum= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and roomnum= '"+keyword2+ "'";
} 
if(!keyword3.equals("")){
    sqlStr += " and isrepair= '"+keyword3+ "'";
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
		     sendrepairlist = new Vector(recordCount);
			 int i=0;
              while (rs.next() && i<pageSize){
                                sendrepair sendrepair = new sendrepair();
                                sendrepair.setId(rs.getLong("id"));
                                sendrepair.setbuildnum(rs.getString("buildnum"));
								sendrepair.setcellnum(rs.getString("cellnum"));
								sendrepair.setroomnum(rs.getString("roomnum"));
								sendrepair.setrepairgoods(rs.getString("repairgoods"));
                                sendrepair.setrepairpersonname(rs.getString("repairpersonname"));
								sendrepair.setrepairtime(rs.getString("repairtime"));
								sendrepair.setisrepair(rs.getString("isrepair"));
								sendrepair.setrepairedtime(rs.getString("repairedtime"));
								sendrepair.setisrepaired(rs.getString("isrepaired"));
															                               
                                sendrepairlist.addElement(sendrepair);
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
* 完成物业报修添加
* @return
* @throws java.lang.Exception
*/
 public boolean insert() throws Exception {
  sqlStr = "insert into dbo.sendrepair (buildnum,cellnum,roomnum,repairgoods,repairpersonname,repairtime,isrepair,repairedtime,isrepaired) values ('";
           sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getbuildnum()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getcellnum()) + "','";
           sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getroomnum()) + "','";   
		   sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getrepairgoods()) + "','"; 
           sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getrepairpersonname())+"','";
		   sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getrepairtime())+"','";
		   sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getisrepair())+"','";
		   sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getrepairedtime())+"','";
		   sqlStr = sqlStr + dataFormat.toSql(asendrepairs.getisrepaired())+"')";
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
* 完成物业报修修改
* @return
* @throws java.lang.Exception
*/
public boolean update() throws Exception {
  sqlStr = "update dbo.sendrepair set ";
  sqlStr = sqlStr + "buildnum = '" + dataFormat.toSql(asendrepairs.getbuildnum()) + "',";
  sqlStr = sqlStr + "cellnum = '" + dataFormat.toSql(asendrepairs.getcellnum()) + "',";
  sqlStr = sqlStr + "roomnum = '" + dataFormat.toSql(asendrepairs.getroomnum()) + "',"; 
  sqlStr = sqlStr + "repairgoods = '" + dataFormat.toSql(asendrepairs.getrepairgoods()) + "',"; 
  sqlStr = sqlStr + "repairpersonname = '" + dataFormat.toSql(asendrepairs.getrepairpersonname()) + "', ";
  sqlStr = sqlStr + "repairtime = '" + dataFormat.toSql(asendrepairs.getrepairtime()) + "', ";
  sqlStr = sqlStr + "isrepair = '" + dataFormat.toSql(asendrepairs.getisrepair()) + "', ";
  sqlStr = sqlStr + "repairedtime = '" + dataFormat.toSql(asendrepairs.getrepairedtime()) + "', ";
  sqlStr = sqlStr + "isrepaired = '" + dataFormat.toSql(asendrepairs.getisrepaired()) + "' ";
  sqlStr = sqlStr + "where id = " + asendrepairs.getId();
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
* 完成物业报修删除
* @param aid
* @return
* @throws java.lang.Exception
*/
public boolean delete( int aid ) throws Exception {
                sqlStr = "delete from dbo.sendrepair where id = "  + aid ;
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
* 完成物业报修单记录查询，用于支持页面的查看物业报修详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnesendrepair(int newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.buildnum,a.cellnum,a.roomnum,"+
        "a.repairgoods,a.repairpersonname,a.repairtime,a.isrepair,a.repairedtime,a.isrepaired from dbo.sendrepair a where a.Id = " + newid ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	sendrepairlist = new Vector(1);
							sendrepair sendrepair = new sendrepair();
							sendrepair.setId(rs.getLong("id"));
							sendrepair.setbuildnum(rs.getString("buildnum"));
							sendrepair.setcellnum(rs.getString("cellnum"));
							sendrepair.setroomnum(rs.getString("roomnum"));
							sendrepair.setrepairgoods(rs.getString("repairgoods"));
							sendrepair.setrepairpersonname(rs.getString("repairpersonname"));
							sendrepair.setrepairtime(rs.getString("repairtime"));
							sendrepair.setrepairedtime(rs.getString("repairedtime"));
							sendrepair.setisrepaired(rs.getString("isrepaired"));
							sendrepair.setisrepair(rs.getString("isrepair"));

							sendrepairlist.addElement(sendrepair);
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
* 完成物业报修单记录查询，用于支持页面的查看物业报修详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnesendrepair1(String newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.buildnum,a.cellnum,a.roomnum,"+
        "a.repairgoods,a.repairpersonname,a.repairtime,a.isrepair,a.repairedtime,a.isrepaired from dbo.sendrepair a where a.buildnum = '" + newid+"'" ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	sendrepairlist = new Vector(1);
							sendrepair sendrepair = new sendrepair();
							sendrepair.setId(rs.getLong("id"));
							sendrepair.setbuildnum(rs.getString("buildnum"));
							sendrepair.setcellnum(rs.getString("cellnum"));
							sendrepair.setroomnum(rs.getString("roomnum"));
							sendrepair.setrepairgoods(rs.getString("repairgoods"));
							sendrepair.setrepairpersonname(rs.getString("repairpersonname"));
							sendrepair.setrepairtime(rs.getString("repairtime"));
							sendrepair.setrepairedtime(rs.getString("repairedtime"));
							sendrepair.setisrepaired(rs.getString("isrepaired"));
							sendrepair.setisrepair(rs.getString("isrepair"));


							
							sendrepairlist.addElement(sendrepair);
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
        public int getPageSize(){			    //每页显示的物业报修数
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
        
  public op_sendrepair() {
       }
}