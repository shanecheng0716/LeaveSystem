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

	String FORM_NO=request.getParameter("FORM_NO_alter");
   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="TEST"; 
        String password="test";
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
       

       
        String sql="UPDATE FORM_HEAD_OF_PSEUDOMONAS SET pse_Status=3 WHERE FORM_NO = '"+FORM_NO+"'";
        ResultSet rs=stmt.executeQuery(sql);
        

        rs.close();		
        stmt.close(); 
        conn.close();
            
    }

    catch(Exception e)
    {
        //out.println("An exception occurred: " + e.getMessage());
        out.println(e);
    }
   	
   
	
   	
   	%>
   	<script>        
                	alert("假單刪除成功");
	</script>
   	<%
   		response.setHeader("Refresh", "0; URL = leave_getleave.jsp");
    %>

</body>
</html>