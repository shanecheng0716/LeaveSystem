<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改代碼</title>
</head>
<body>

<% 
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=utf-8");	
String input_no2=request.getParameter("input_no2");
String input_type=(String)session.getAttribute("input_type");
String no_sql="";

if(input_no2.equals("")){
  %>
	<script>
    alert("請輸入變更名稱"); 
    window.history.back(-1); 
  </script>
  <%
}else{
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
    
    String sql1="SELECT LEAVE_no FROM TYPE_OF_LEAVE WHERE LEAVE_no ='"+ input_no2 +"'";
    ResultSet rs=stmt.executeQuery(sql1);
    if(rs.next()){
    	no_sql = rs.getString("leave_no");
    }
    if(no_sql.equals(input_no2)){
    	%>
    	  <script>
    	    alert("代碼已重複"); 
    	    window.history.back(-1);
    	  </script>
    	  <% 	
    }
    
    String sql="UPDATE TYPE_OF_LEAVE SET leave_no='"+ input_no2 +"' WHERE leave_type='"+ input_type +"'";
    rs=stmt.executeQuery(sql);

    rs.close();
    stmt.close(); 
    conn.close();
  }

  catch(Exception e)
  {
    out.println(e);
  }
}
%> 

<%
	
	session.removeAttribute("input_no");
	session.removeAttribute("input_type2");

%>
  <script>
    alert("假別代碼已變更!"); 
    location.href="Category.jsp";
  </script>
</body>
</html>