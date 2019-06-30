<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>假別刪除</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>

<%
	
	
	String input_type=(String)session.getAttribute("input_type");
	String input_no=(String)session.getAttribute("input_no");
%>

<%
    try 
    {  
  //22
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
        
        //使用者帳號，密碼
        String user="test"; //帳號 
        String password="test"; //密碼 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
        String sql="DELETE FROM TYPE_OF_LEAVE WHERE leave_no='"+ input_no +"' AND leave_type='"+ input_type +"'"; 
        				//資料庫語法
        ResultSet rs=stmt.executeQuery(sql); 
        
        rs.close(); 
        stmt.close(); 
        conn.close();
            
    }

    catch(Exception e)
    {
        //out.println("An exception occurred: ");
        out.println(e);
    }

%> 

<%
	
	session.removeAttribute("input_no");
	session.removeAttribute("input_type");
%>
     <script>
       alert("假別已刪除!"); 
       location.href="Category.jsp";
     </script>
</body>
</html>