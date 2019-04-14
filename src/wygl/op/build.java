package wygl.op;

/**
* 楼盘类
*/

public class build {
        private long Id;		        //ID序列号
        private String buildnum;	    //楼盘编号
        private String name;	        //楼盘名称
        private String addr ;           //楼盘位置
        private String info;	        //楼盘介绍
        
        
        
 /**
 * 楼盘类初始化
 */
        public build() {
                Id = 0;
                buildnum = "";
                name = "";
                addr = "";
                info = "";
                
                
        }
        public void setId(long newId){
                this.Id = newId;
        }
        public long getId(){
                return Id;
        }
		public void setbuildnum(String newbuildnum) {
                this.buildnum = newbuildnum;
        }
        public String getbuildnum() {
                return buildnum;
        }
        public void setname(String newname) {
                this.name = newname;
        }
        public String getname() {
                return name;
        }
        public void setaddr(String newaddr) {
                this.addr = newaddr;
        }
        public String getaddr() {
                return addr;
        }
        
        public void setinfo(String newinfo) {
                this.info = newinfo;
        }
        public String getinfo() {
                return info;
        }
			

		public build(int newId,String newbuildnum,String newname) {
                Id = newId;
				buildnum = newbuildnum;
				name = newname;
								
              }
 
};
