package wygl.vo;

public class userVo {
     private String yh;	    
     private String name;		   
	 private String dep;		    	
	 private String acl;
	public String getYh() {
		return yh;
	}
	public void setYh(String yh) {
		this.yh = yh;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDep() {
		return dep;
	}
	public void setDep(String dep) {
		this.dep = dep;
	}
	public String getAcl() {
		return acl;
	}
	public void setAcl(String acl) {
		this.acl = acl;
	}
	public String toString() {
		return "userVo [yh=" + yh + ", name=" + name + ", dep=" + dep
				+ ", acl=" + acl + "]";
	}
	 
	 
	 
}
