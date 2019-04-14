package wygl.op;

/**
 * <p>用户类 </p>
 */

public class user {
        private long Id;		          //ID序列号
        private String yh;	    
        private String name;		   
		private String dep;		    
		private String password;		
		private String acl;		    
			    
		
        		
       
/**
* 用户类的初始化
*/
        public user() {
                Id = 0;
                yh = "";	    
                name = "";		   
		        dep = "";		    
		        password = "";		
		        acl = "";		    
		       
                         
        }
        public void setId(long newId){
                this.Id = newId;
        }
        public long getId(){
                return Id;
        }
        public void setyh(String newyh) {
                this.yh = newyh;
        }
        public String getyh() {
                return yh;
        }
        public void setname(String newname) {
                this.name = newname;
        }
        public String getname() {
                return name;
        }
        public void setdep(String newdep) {
                this.dep = newdep;
        }
        public String getdep() {
                return dep;
        }
        public void setpassword(String newpassword) {
                this.password = newpassword;
        }
        public String getpassword() {
                return password;
        }
		public void setacl(String newacl) {
                this.acl = newacl;
        }
        public String getacl() {
                return acl;
        }
		

};
