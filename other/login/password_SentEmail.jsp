<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.mail.DefaultAuthenticator" %>
<%@ page import="org.apache.commons.mail.Email" %>
<%@ page import="org.apache.commons.mail.EmailException" %>
<%@ page import="org.apache.commons.mail.HtmlEmail" %>
<%	int strLen = 8;			// default length:6
int num = 0;			// 隨機字符碼
String outStr = "";		// 產生的密碼
	while(outStr.length() < strLen)  {
		num = (int)(Math.random()*(90-50+1))+50;	//亂數取編號為 50~90 的字符	(排除 0 和 1)
		if (num > 57 && num < 65)
			continue;			//排除非數字非字母
		else if (num == 73 || num == 76 || num == 79)
			continue;			//排除 I、L、O
		outStr += (char)num;
	}
    String EMAIL = (String)session.getAttribute("EMAIL");
	String FORM_NO_value= (String)session.getAttribute("FORM_NO");
    String subject= "新密碼";
    String message = "新的密碼為: " +outStr ;
    Email email = new HtmlEmail(); 
	String authuser = "alex83810@gmail.com"; 
	String authpwd = "a79856410";
	email.setHostName("smtp.gmail.com");
	email.setSmtpPort(465); 
	email.setAuthenticator(new DefaultAuthenticator(authuser, authpwd));
	email.setDebug(true);
	email.setSSL(true);
	email.setSslSmtpPort("465");
	email.setCharset("UTF-8");
	email.setSubject(subject);
	try {
	    email.setFrom("alex83810@gmail.com", "人資系統");
	    email.setMsg(message); 
	    email.addTo(EMAIL, "員工");
	    email.send();
	} catch (EmailException e) {
	    e.printStackTrace();
	}
	response.setHeader("Refresh", "0; URL = password_Upatepassword.jsp");
	session.setAttribute("PASSWORD",outStr);
 %>