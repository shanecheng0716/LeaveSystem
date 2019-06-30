<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=utf-8");    
String input_type2=request.getParameter("input_type2");
String input_no=(String)session.getAttribute("input_no");
String type_sql="";

if(input_type2.equals("")){
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
    
    String sql1="SELECT LEAVE_TYPE FROM TYPE_OF_LEAVE WHERE LEAVE_TYPE ='"+ input_type2 +"'";
    ResultSet rs=stmt.executeQuery(sql1);
    if(rs.next()){
    	type_sql = rs.getString("leave_type");
    }
    if(type_sql.equals(input_type2)){
    	%>
    	  <script>
    	    alert("假別已重複"); 
    	    window.history.back(-1);
    	  </script>
    	  <% 	
    }
    
    
    String sql="UPDATE TYPE_OF_LEAVE SET leave_type='"+ input_type2 +"' WHERE leave_no='"+ input_no +"'";
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
    alert("假別名稱已變更!"); 
    location.href=('Category.jsp');
  </script>
</body>
</html>