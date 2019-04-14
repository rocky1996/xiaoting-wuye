package wygl.op;

/**
* 投诉类
*/

public class lodgecomplaint {
        private long Id;		        //ID序列号
        private String buildnum;	    //楼盘
        private String cellnum;	        //单元
        private String roomnum ;        //房间
		private String lodgeusername ;  //投诉人
        private String reason;	        //投诉内容
        
        
        
 /**
 * 投诉类初始化
 */
        public lodgecomplaint() {
                Id = 0;
                buildnum = "";
                cellnum = "";
                roomnum = "";
				lodgeusername="";
                reason = "";
                
                
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

		public void setlodgeusername(String newlodgeusername) {
                this.lodgeusername = newlodgeusername;
        }
        public String getlodgeusername() {
                return lodgeusername;
        }
        
        public void setreason(String newreason) {
                this.reason = newreason;
        }
        public String getreason() {
                return reason;
        }
			

		public lodgecomplaint(int newId,String newbuildnum,String newlodgeusername) {
                Id = newId;
				buildnum = newbuildnum;
				lodgeusername = newlodgeusername;
								
              }
 
};
