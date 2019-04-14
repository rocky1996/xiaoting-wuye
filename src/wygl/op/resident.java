package wygl.op;

/**
* 住户类
*/

public class resident {
        private long Id;		            //ID序列号
        private String residentnum;	        //住户编号
        private String name;	            //住户名称
        private String buildnum ;           //住户楼盘
        private String cellnum;	            //住户单元
        private String roomnum;	            //住户房间
		private String area;	            //面积
		private String otherinfo;	        //其它信息
        
        
        
 /**
 * 住户类初始化
 */
        public resident() {
                Id = 0;
                residentnum = "";
                name = "";
                buildnum = "";
                cellnum = "";
				roomnum="";
				area="";
				otherinfo="";
                
                
        }
        public void setId(long newId){
                this.Id = newId;
        }
        public long getId(){
                return Id;
        }
		public void setresidentnum(String newresidentnum) {
                this.residentnum = newresidentnum;
        }
        public String getresidentnum() {
                return residentnum;
        }
        public void setname(String newname) {
                this.name = newname;
        }
        public String getname() {
                return name;
        }
        public void setbuildnum(String newbuildnum) {
                this.buildnum = newbuildnum;
        }
        public String getbuildnum() {
                return buildnum;
        }
        
        public void setcellnum(String newcellnum) {
                this.cellnum = newcellnum;
        }
        public String getcellnum() {
                return cellnum;
        }
			
		public void setroomnum(String newroomnum) {
                this.roomnum = newroomnum;
        }
        public String getroomnum() {
                return roomnum;
        }

		public void setarea(String newarea) {
                this.area = newarea;
        }
        public String getarea() {
                return area;
        }

		public void setotherinfo(String newotherinfo) {
                this.otherinfo = newotherinfo;
        }
        public String getotherinfo() {
                return otherinfo;
        }


		public resident(int newId,String newresidentnum,String newname) {
                Id = newId;
				residentnum = newresidentnum;
				name = newname;
								
              }
 
};
