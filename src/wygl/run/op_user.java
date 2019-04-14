package wygl.run;
/**
 * <p>管理用户的类，包括用户的修改、查询，删除，添加 </p>
 */
import java.sql.*;
import java.util.Vector;
import wygl.util.*;
import wygl.op.*;
import javax.servlet.http.HttpServletRequest;

public class op_user extends DataBase{
	
  private user ausers = new user();	                                //新的类
        private javax.servlet.http.HttpServletRequest request;      //建立页面请求
        private boolean sqlflag = true ;		                    //对接收到的数据是否正确
        private Vector userlist;			                        //显示列表向量数组
		 private int page = 1;				                        //显示的页码
        private int pageSize=8;				                    //每页显示数
        private int pageCount =0;				                    //页面总数
        private int recordCount =0;			                        //查询的记录总数
        public String sqlStr="";
        public Vector getuserlist() {
                return userlist;
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
   long userid = 0;
   try{
           userid = Long.parseLong(ID);
   }catch (Exception e){
   }
   ausers.setId(userid);

   String yh = request.getParameter("yh");
   if (yh==null || yh.equals(""))   {       yh = "-";sqlflag = false; }
   ausers.setyh(to_String(yh));

   String name = request.getParameter("name");
   if (name==null || name.equals(""))   {         name = "-";   }
   ausers.setname(to_String(name));

   String dep = request.getParameter("dep");
   if (dep==null || dep.equals(""))   {         dep = "-";   }
   ausers.setdep(to_String(dep));
   
   String password = request.getParameter("password");
   if (password==null || password.equals(""))   {         password = "-";   }
   ausers.setpassword(to_String(password));

   String acl = request.getParameter("acl");
   if (acl==null || acl.equals(""))   {         acl = "-";   }
   ausers.setacl(to_String(acl));


   

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
* 完成用户添加
* @return
* @throws java.lang.Exception
*/
public boolean insert() throws Exception {
sqlStr = "insert into dbo.users(yh,name,dep,password,acl) values ('";
           sqlStr = sqlStr + dataFormat.toSql(ausers.getyh()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(ausers.getname()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(ausers.getdep()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(ausers.getpassword()) + "','";
		   
           sqlStr = sqlStr + dataFormat.toSql(ausers.getacl())+"')";
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
* 完成用户修改
* @return
* @throws java.lang.Exception
*/
public boolean update() throws Exception {
  sqlStr = "update dbo.users set ";
  sqlStr = sqlStr + "yh = '" + dataFormat.toSql(ausers.getyh()) + "',";
  sqlStr = sqlStr + "name = '" + dataFormat.toSql(ausers.getname()) + "',";
  sqlStr = sqlStr + "dep = '" + dataFormat.toSql(ausers.getdep()) + "',";
  sqlStr = sqlStr + "password = '" + dataFormat.toSql(ausers.getpassword()) + "',";
  sqlStr = sqlStr + "acl = '" + dataFormat.toSql(ausers.getacl()) + "' ";
  
  sqlStr = sqlStr + "where id = " + ausers.getId();
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
* 完成用户删除
* @param aid
* @return
* @throws java.lang.Exception
*/
public boolean delete( int aid ) throws Exception {
                sqlStr = "delete from dbo.users where id = "  + aid ;
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
 * 完成用户单条记录查询，用于支持页面的查看用户详细资料
 * @param newid
 * @return
 */
 public boolean getOneuser(int newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
	sqlStr="select  a.id,a.yh,a.name,a.dep,a.password,a.acl from dbo.users a where a.Id = " + newid ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	userlist = new Vector(1);
                                user user = new user();
                                user.setId(rs.getLong("id"));
                                user.setyh(rs.getString("yh"));
                                user.setname(rs.getString("name"));
                                user.setdep(rs.getString("dep"));
								user.setpassword(rs.getString("password"));
								user.setacl(rs.getString("acl"));
								userlist.addElement(user);
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
* 完成新闻查询，包括分类，分页查询
* @param res
* @return
* @throws java.lang.Exception
*/
public boolean user_search(HttpServletRequest res) throws Exception {
   DataBase db = new DataBase();
   db.connect();
   stmt = db.conn.createStatement ();
   request = res;
   String PAGE = request.getParameter("page");   //页码
     
   try {
           page = Integer.parseInt(PAGE);
   }catch (NumberFormatException e){
           page = 1;
		   PAGE ="1";
   }
   
           sqlStr = "select count(*) from dbo.users ";
   
   
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
   
  
	        sqlStr = "select * from dbo.users  order by id desc";
		 	
			if(recordCount < pageSize){
			  pageCount=1;
		    }else{
	 	      pageCount=(int)(recordCount - 1) / pageSize + 1;
            }
          

        try  {
			 QueryPage fy = new QueryPage();
			 rs =fy.getPageof(sqlStr, PAGE, pageSize,recordCount);
		     userlist = new Vector(recordCount);
			 int i=0;
              while (rs.next() && i<pageSize){
                                user user = new user();
                                user.setId(rs.getLong("id"));
                                user.setyh(rs.getString("yh"));
                                user.setname(rs.getString("name"));
                                user.setdep(rs.getString("dep"));
                                user.setpassword(rs.getString("password"));
                                user.setacl(rs.getString("acl"));                                
                                userlist.addElement(user);
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
       
		
		public int getPage() {				//显示的页码
                return page;
        }
        public void setPage(int newpage) {
                page = newpage;
        }
        public int getPageSize(){			//每页显示的图书数
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
        public int getrecordCount() {
                return recordCount;
        }




  public op_user() {
       }
}