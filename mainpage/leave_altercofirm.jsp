<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%> 
<%@ page import="org.apache.commons.mail.DefaultAuthenticator" %>
<%@ page import="org.apache.commons.mail.Email" %>
<%@ page import="org.apache.commons.mail.EmailException" %>
<%@ page import="org.apache.commons.mail.HtmlEmail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
		
</head>
</head>
<body>
<%
	String DETAILS_NO=(String)session.getAttribute("DETAILS_NO");
	String FORM_NO=(String)session.getAttribute("FORM_NO");
 	String Today=(String)session.getAttribute("Today");
 	String EMP_ID=(String)session.getAttribute("EMP_ID");
 	String EMP_NAME=(String)session.getAttribute("EMP_NAME");
 	String leavekinds=(String)session.getAttribute("leavekinds");
 	String date1=(String)session.getAttribute("date1");
 	String date2=(String)session.getAttribute("date2");
 	String hours2 = request.getParameter("hours2");
 	String agent=(String)session.getAttribute("agent");
 	String reason=(String)session.getAttribute("reason");
 	String DEPARTMENT=(String)session.getAttribute("DEPARTMENT");
 	String EMAIL = "";
   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="TEST"; 
        String password="test";
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
       
        String sql1="UPDATE DETAILS_OF_PSEUDOMONAS SET START_TIME = to_date('"+ date1 +"','YYYY-MM-DD HH24:MI'),END_TIME = to_date('"+ date2 +"','YYYY-MM-DD HH24:MI'), HOURS='"+hours2+"' , LEAVES='"+leavekinds+"' ,REASON='"+reason+"' WHERE FORM_NO = '"+FORM_NO+"'";
        ResultSet rs=stmt.executeQuery(sql1);  
       
        String sql2="UPDATE FORM_HEAD_OF_PSEUDOMONAS SET AGENT = '"+agent+"',APPLY_TIME = to_date('"+ Today +"','YYYY-MM-DD HH24:MI'),PSE_STATUS =0 WHERE FORM_NO = '"+FORM_NO+"'";
        rs=stmt.executeQuery(sql2);
        
        String sql3="SELECT EMAIL FROM STAFF_DATA WHERE DEPARTMENT='"+DEPARTMENT+"' AND (OCCUPATION='主管' OR  OCCUPATION='董事長')";
        ResultSet rs2=stmt.executeQuery(sql3);
        while(rs2.next()) 
        {	
        EMAIL = rs2.getString("EMAIL");
        }
       

       
      
  		//明細編號尚未完成
  		//表單編號
        
        rs.close();		
        stmt.close(); 
        conn.close();
            
    }

    catch(Exception e)
    {
        //out.println("An exception occurred: " + e.getMessage());
        out.println(e);
    }
   	
   	String subject="員工請假通知";
    String message="您部門的員工:"+EMP_NAME+"，重新申請一則假單，請前往審核";
    
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
   	
   	session.removeAttribute("DETAILS_NO");
   	session.removeAttribute("FORM_NO");
   	session.removeAttribute("Today");
   	session.removeAttribute("EMP_ID");
   	session.removeAttribute("EMP_NAME");
   	session.removeAttribute("leavekinds");   	
   	session.removeAttribute("date1");
   	session.removeAttribute("date2");
   	session.removeAttribute("hours2");
   	session.removeAttribute("agent");
   	session.removeAttribute("reason");
   	session.removeAttribute("DEPARTMENT");
   	
   	
   	session.removeAttribute("DETAILS_NO");
   	session.removeAttribute("FORM_NO");
   	session.removeAttribute("Today");
   	session.removeAttribute("EMP_NAME");
   	session.removeAttribute("leavekinds");
   	session.removeAttribute("date1");
   	session.removeAttribute("date2");
   	session.removeAttribute("hours2");
   	session.removeAttribute("agent");
   	session.removeAttribute("reason");
	session.removeAttribute("DEPARTMENT");
   	
   	%>
   	<script>        
                	alert("假單修改成功");
	</script>
   	<%
   		response.setHeader("Refresh", "0; URL = leave_getleave.jsp");
    %>

</body>
</html>