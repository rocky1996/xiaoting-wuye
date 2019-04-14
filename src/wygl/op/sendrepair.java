package wygl.op;

/**
* 物业报修类
*/

public class sendrepair {
        private long Id;		            //ID序列号
        private String buildnum;	        //楼盘编号
        private String cellnum;	            //单元编号
        private String roomnum ;            //房间编号
		private String repairgoods ;        //报修物品
        private String repairpersonname;	//报修人
		private String repairtime;	        //报修时间
		private String isrepair;	        //是否报修
		private String repairedtime;	    //报修时间
		private String isrepaired;	        //是否修理完
        
        
        
 /**
 * 物业报修类初始化
 */
        public sendrepair() {
                Id = 0;
                buildnum = "";
                cellnum = "";
                roomnum = "";
				repairgoods="";
                repairpersonname = "";
				repairtime="";	        
		        isrepair="";	       
		        repairedtime="";	    
		        isrepaired="";	        
                
                
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
        public void setrepairgoods(String newrepairgoods) {
                this.repairgoods = newrepairgoods;
        }
        public String getrepairgoods() {
                return repairgoods;
        }
        public void setrepairpersonname(String newrepairpersonname) {
                this.repairpersonname = newrepairpersonname;
        }
        public String getrepairpersonname() {
                return repairpersonname;
        }
		
			public void setrepairtime(String newrepairtime) {
                this.repairtime = newrepairtime;
        }
        public String getrepairtime() {
                return repairtime;
        }

        public void setisrepair(String newisrepair) {
                this.isrepair = newisrepair;
        }
        public String getisrepair() {
                return isrepair;
        }

        public void setrepairedtime(String newrepairedtime) {
                this.repairedtime = newrepairedtime;
        }
        public String getrepairedtime() {
                return repairedtime;
        }

        public void setisrepaired(String newisrepaired) {
                this.isrepaired = newisrepaired;
        }
        public String getisrepaired() {
                return isrepaired;
        }

		public sendrepair(int newId,String newbuildnum,String newroomnum) {
                Id = newId;
				buildnum = newbuildnum;
				roomnum = newroomnum;
								
              }
 
};
