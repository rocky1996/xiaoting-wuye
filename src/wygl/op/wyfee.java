package wygl.op;

/**
* 物业费类
*/

public class wyfee {
        private long Id;		        //ID序列号
        private String feenum;	        //物业费编号
        private String buildnum;	        //物业费名称
        private String cellnum ;       //物业费金额
		private String roomnum ;     //收取时间
        private String ispayment;	        //物业费备注
		private String shouqurq;	        //物业费备注
        
        
        
 /**
 * 物业费类初始化
 */
        public wyfee() {
                Id = 0;
                feenum = "";
                buildnum = "";
                cellnum = "";
				roomnum="";
                ispayment = "";
				shouqurq="";
                
                
        }
        public void setId(long newId){
                this.Id = newId;
        }
        public long getId(){
                return Id;
        }
		public void setfeenum(String newfeenum) {
                this.feenum = newfeenum;
        }
        public String getfeenum() {
                return feenum;
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
        public void setispayment(String newispayment) {
                this.ispayment = newispayment;
        }
        public String getispayment() {
                return ispayment;
        }
		public void setshouqurq(String newshouqurq) {
                this.shouqurq = newshouqurq;
        }
        public String getshouqurq() {
                return shouqurq;
        }
			

		public wyfee(int newId,String newfeenum,String newbuildnum) {
                Id = newId;
				feenum = newfeenum;
				buildnum = newbuildnum;
								
              }
 
};
