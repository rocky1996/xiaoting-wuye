<%@ page language="java" import="java.util.*" pageEncoding="GBK"%><%
String time,rq;
	int year,month,day,hour,minute,second;
	GregorianCalendar calendar;
	calendar=new GregorianCalendar();
	year=calendar.get(Calendar.YEAR);
	month=calendar.get(Calendar.MONTH)+1;
	day=calendar.get(Calendar.DAY_OF_MONTH);
	hour=calendar.get(Calendar.HOUR_OF_DAY);
	minute=calendar.get(Calendar.MINUTE);
	second=calendar.get(Calendar.SECOND);
	
	rq=year+"-"+month+"-"+day+"";
	time=hour+":"+minute+":"+second+":";
	
%>