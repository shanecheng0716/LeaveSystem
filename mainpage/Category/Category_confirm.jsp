<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>假別確認</title>
</head>
<body>

<%
	
	String input_no=(String)session.getAttribute("input_no");
	String input_type=(String)session.getAttribute("input_type");
	
%>

<%
    try 
    {  
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
        
        //使用者帳號，密碼
        String user="test"; //帳號 
        String password="test"; //密碼 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
        String sql="INSERT INTO TYPE_OF_LEAVE (leave_no,leave_type) VALUES('"+input_no+"',"+"'"+ input_type +"')";
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
	session.removeAttribute("input_type");%>   
    <script>
      alert("假別已新增!");
      location.href="Category.jsp";
    </script>
</body>
</html>