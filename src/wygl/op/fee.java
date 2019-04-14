package wygl.op;

/**
* 物业费类
*/

public class fee {
        private long Id;		        //ID序列号
        private String feenum;	        //物业费编号
        private String feename;	        //物业费名称
        private String moneynum ;       //物业费金额
		private String shouqutime ;     //收取时间
        private String info;	        //物业费备注
        
        
        
 /**
 * 物业费类初始化
 */
        public fee() {
                Id = 0;
                feenum = "";
                feename = "";
                moneynum = "";
				shouqutime="";
                info = "";
                
                
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
        public void setfeename(String newfeename) {
                this.feename = newfeename;
        }
        public String getfeename() {
                return feename;
        }
        public void setmoneynum(String newmoneynum) {
                this.moneynum = newmoneynum;
        }
        public String getmoneynum() {
                return moneynum;
        }
        public void setshouqutime(String newshouqutime) {
                this.shouqutime = newshouqutime;
        }
        public String getshouqutime() {
                return shouqutime;
        }
        public void setinfo(String newinfo) {
                this.info = newinfo;
        }
        public String getinfo() {
                return info;
        }
			

		public fee(int newId,String newfeenum,String newfeename) {
                Id = newId;
				feenum = newfeenum;
				feename = newfeename;
								
              }
 
};
