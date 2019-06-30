<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.mail.DefaultAuthenticator" %>
<%@ page import="org.apache.commons.mail.Email" %>
<%@ page import="org.apache.commons.mail.EmailException" %>
<%@ page import="org.apache.commons.mail.HtmlEmail" %>
<%
	String EMAIL = (String)session.getAttribute("EMAIL");
	String FORM_NO_value= (String)session.getAttribute("FORM_NO");
	String PSE_STATUS= (String)session.getAttribute("PSE_STATUS");
	String VERIFY_REASON= (String)session.getAttribute("VERIFY_REASON");
	String subject="";
	String message="";

	if(PSE_STATUS.equals("1")){
    	subject= "您的假單已被審核通過";
    	if(VERIFY_REASON.equals("")){
    		message = "您的假單已被審核通過，審核通過的假單編號為： \n\n" +FORM_NO_value;
    	}
    	else{
    	message = "您的假單已被審核通過，審核通過的假單編號為： \n\n" +FORM_NO_value + "\n\n通過原因： \n\n" + VERIFY_REASON;
    	}
	}
	else{
    	subject= "您的假單已被核退";
    	message = "您的假單已被核退，被核退的假單編號為： \n\n" +FORM_NO_value + "\n\n核退原因： \n\n" +VERIFY_REASON;
	}
	
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
 %>
<script>alert("通知審核結果郵件已發送成功!"); 
	 window.location='check_getleave.jsp'; </script>