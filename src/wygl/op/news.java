package wygl.op;

/**
* 小区公告类
*/

public class news {
        private long Id;		        //ID序列号
        private String title;	        //小区公告编号
        private String contant;	        //小区公告名称
        private String senddate ;       //小区公告金额
		
        
        
 /**
 * 小区公告类初始化
 */
        public news() {
                Id = 0;
                title = "";
                contant = "";
                senddate = "";
				
                
        }
        public void setId(long newId){
                this.Id = newId;
        }
        public long getId(){
                return Id;
        }
		public void settitle(String newtitle) {
                this.title = newtitle;
        }
        public String gettitle() {
                return title;
        }
        public void setcontant(String newcontant) {
                this.contant = newcontant;
        }
        public String getcontant() {
                return contant;
        }
        public void setsenddate(String newsenddate) {
                this.senddate = newsenddate;
        }
        public String getsenddate() {
                return senddate;
        }
        			

		public news(int newId,String newtitle) {
                Id = newId;
				title = newtitle;
											
              }
 
};
