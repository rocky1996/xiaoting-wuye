package wygl.util;

import java.util.*;
import java.text.*;
import java.io.*;

public class Truncate {

	
	
	public static String truncate(String source, int len, String delim) {
		if (source == null) return null;
		int start, stop , byteLen ;
		int alen = source.getBytes().length;
		//len += len ;
		if (len > 0) {
			if (alen <= len) return source;
			start = stop = byteLen = 0; //TODO effizienter
			//stop = (len > alen ? alen : len);
			
			while ( byteLen <= len){
				if ( source.substring(stop,stop+1).getBytes().length == 1){
					byteLen += 1 ;
				}else{
					byteLen += 2 ;
				}
				stop++;
			}
			StringBuffer sb = new StringBuffer(source.substring(start, stop-1));
			if (alen > len) sb.append(delim);
			return sb.toString();
		}
		start = (len < -alen ? 0 : alen + len);
		stop = alen;
		StringBuffer sb = new StringBuffer(source.substring(start/2, stop/2));
		if (-alen <= len) sb.insert(0, delim);
		return sb.toString();
	}

public boolean bq(String rq1, String rq2,String path,String wj) throws Exception {
long t=0;
      SimpleDateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");
      try {
         Date start = smdf.parse(rq1);
         Date end = smdf.parse(rq2);
         t = (end.getTime() - start.getTime()) / (3600 * 24 * 1000);
          } catch (ParseException e) {
          e.printStackTrace();
          }
    if(t>30){
         File f=new File(path,wj);
         f.delete();
     }
	return true;	
}


}
