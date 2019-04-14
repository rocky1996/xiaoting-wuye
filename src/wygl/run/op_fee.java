package wygl.run;
/**
 * <p>管理物业费的类，包括物业费的修改、查询，删除，添加 </p>
 */
import java.sql.*;
import java.util.Vector;
import wygl.util.*;
import wygl.op.*;
import javax.servlet.http.HttpServletRequest;
import wygl.util.QueryPage;

public class op_fee extends DataBase{
  private fee afees = new fee();	                           //新的物业费类
        private javax.servlet.http.HttpServletRequest request; //建立页面请求
        private boolean sqlflag = true ;		               //对接收到的数据是否正确
        private Vector feelist;			                   //显示物业费列表向量数组
        private int page = 1;				                   //显示的页码
        private int pageSize=15;				               //每页显示的记录数
        private int pageCount =0;				               //页面总数
        private int recordCount =0;			                   //查询的记录总数
        public String sqlStr="";
        public Vector getfeelist() {
                return feelist;
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
   afees.setId(lvdid);

   String feenum = request.getParameter("feenum");
   if (feenum==null || feenum.equals("")){feenum = "";sqlflag = false;}
   afees.setfeenum(to_String(feenum));

   String feename = request.getParameter("feename");
   if (feename==null || feename.equals(""))   {  feename = "";sqlflag = false; }
   afees.setfeename(to_String(feename));

   String moneynum = request.getParameter("moneynum");;
   if (moneynum==null) {      moneynum = "";  }
   afees.setmoneynum(to_String(moneynum));

   String shouqutime = request.getParameter("shouqutime");;
   if (shouqutime==null) {      shouqutime = "";  }
   afees.setshouqutime(to_String(shouqutime));
   
   String info = request.getParameter("info");
   if (info == null) {        info = "";   }
   afees.setinfo(to_String(info));

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
* 获得查询物业费类别的sql语句
* @return
*/
public String getSql() {
   sqlStr = "select id,feenum,feename from dbo.fee order by id desc";
   return sqlStr;
        }


/**
* 查询所有物业费
* @return
* @throws java.lang.Exception
*/
  public boolean seachallfee() throws Exception {
                  int id = 0;
                  String feenum = "";
				  String feename = "";	
				 
                  int rscount = 0;
                  try {
                  DataBase db = new DataBase();
                  db.connect();
                  stmt = db.conn.createStatement ();
                  rs = stmt.executeQuery(getSql());
                  rscount = stmt.getMaxRows();
                  feelist = new Vector(rscount+1);
                  feelist.clear();
                  while (rs.next()){
                                  id = rs.getInt("id");
                                  feenum = rs.getString("feenum");
								  feename = rs.getString("feename");
								  
								  fee bc = new fee(id,feenum,feename);
                                  feelist.addElement(bc);
								  
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
* 完成物业费查询，包括分类，分页查询
* @param res
* @return
* @throws java.lang.Exception
*/
public boolean fee_search(HttpServletRequest res) throws Exception {
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

 String sqlStr = "select count(*) from dbo.fee where 1=1"; 

if(!keyword1.equals("")){
    sqlStr += " and feename= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and moneynum= '"+keyword2+ "'";
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
sqlStr="select  * from fee a where 1=1" ;


if(!keyword1.equals("")){
    sqlStr += " and feename= '"+keyword1+ "'";
}
if(!keyword2.equals("")){
    sqlStr += " and moneynum= '"+keyword2+ "'";
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
		     feelist = new Vector(recordCount);
			 int i=0;
              while (rs.next() && i<pageSize){
                                fee fee = new fee();
                                fee.setId(rs.getLong("id"));
                                fee.setfeenum(rs.getString("feenum"));
								fee.setfeename(rs.getString("feename"));
								fee.setmoneynum(rs.getString("moneynum"));
								fee.setshouqutime(rs.getString("shouqutime"));
                                fee.setinfo(rs.getString("info"));
															                               
                                feelist.addElement(fee);
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
* 完成物业费添加
* @return
* @throws java.lang.Exception
*/
 public boolean insert() throws Exception {
  sqlStr = "insert into dbo.fee (feenum,feename,moneynum,shouqutime,info) values ('";
           sqlStr = sqlStr + dataFormat.toSql(afees.getfeenum()) + "','";
		   sqlStr = sqlStr + dataFormat.toSql(afees.getfeename()) + "','";
           sqlStr = sqlStr + dataFormat.toSql(afees.getmoneynum()) + "','";   
		   sqlStr = sqlStr + dataFormat.toSql(afees.getshouqutime()) + "','"; 
           sqlStr = sqlStr + dataFormat.toSql(afees.getinfo())+"')";
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
* 完成物业费修改
* @return
* @throws java.lang.Exception
*/
public boolean update() throws Exception {
  sqlStr = "update dbo.fee set ";
  sqlStr = sqlStr + "feenum = '" + dataFormat.toSql(afees.getfeenum()) + "',";
  sqlStr = sqlStr + "feename = '" + dataFormat.toSql(afees.getfeename()) + "',";
  sqlStr = sqlStr + "moneynum = '" + dataFormat.toSql(afees.getmoneynum()) + "',"; 
  sqlStr = sqlStr + "shouqutime = '" + dataFormat.toSql(afees.getshouqutime()) + "',"; 
  sqlStr = sqlStr + "info = '" + dataFormat.toSql(afees.getinfo()) + "' ";
  sqlStr = sqlStr + "where id = " + afees.getId();
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
* 完成物业费删除
* @param aid
* @return
* @throws java.lang.Exception
*/
public boolean delete( int aid ) throws Exception {
                sqlStr = "delete from dbo.fee where id = "  + aid ;
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
* 完成物业费单记录查询，用于支持页面的查看物业费详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnefee(int newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.feenum,a.feename,a.moneynum,"+
        "a.shouqutime,a.info from dbo.fee a where a.id = " + newid ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	feelist = new Vector(1);
							fee fee = new fee();
							fee.setId(rs.getLong("id"));
							fee.setfeenum(rs.getString("feenum"));
							fee.setfeename(rs.getString("feename"));
							fee.setmoneynum(rs.getString("moneynum"));
							fee.setshouqutime(rs.getString("shouqutime"));
							fee.setinfo(rs.getString("info"));
							feelist.addElement(fee);
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
* 完成物业费单记录查询，用于支持页面的查看物业费详细资料
* @param newid
* @return
* @throws java.lang.Exception
*/
 public boolean getOnefee1(String newid ) throws Exception {
     DataBase db = new DataBase();
     db.connect();
     stmt =db.conn.createStatement ();
     try {
        sqlStr="select  a.id,a.feenum,a.feename,a.moneynum,"+
        "a.shouqutime,a.info from dbo.fee a where a.feenum = '" + newid+"'" ;
                        rs = stmt.executeQuery(sqlStr);
                        if (rs.next())
                        {	feelist = new Vector(1);
							fee fee = new fee();
							fee.setId(rs.getLong("id"));
							fee.setfeenum(rs.getString("feenum"));
							fee.setmoneynum(rs.getString("moneynum"));
							fee.setshouqutime(rs.getString("shouqutime"));
							fee.setfeename(rs.getString("feename"));							
							fee.setinfo(rs.getString("info"));
							
							feelist.addElement(fee);
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
        public int getPageSize(){			    //每页显示的物业费数
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
        
  public op_fee() {
       }
}