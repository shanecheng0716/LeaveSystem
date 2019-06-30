<%@ page contentType="text/html; charset=UTF-8" 
  import="java.sql.*"%>
<%String PASSWORD_value = (String)session.getAttribute("PASSWORD"); 
String EMP_ID_value = (String)session.getAttribute("EMP_ID");
	
ResultSet rs = null;
try{
  //連接資料庫(需要IP、PORT、DB_SID)
  Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
  String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
  
  //使用者帳號，密碼
  String user="test"; //帳號 
  String password="test"; //密碼 
  Connection conn= DriverManager.getConnection(url,user,password); 
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
  String sql="UPDATE ACCOUNT_PASSWORD SET ACCOUNT_PASSWORD.PASSWORD = "+"'"+PASSWORD_value+"' WHERE EMP_ID = "+"'"+EMP_ID_value+"'";
  rs=stmt.executeQuery(sql);   
//建立ResultSet(結果集)物件，並執行SQL敘述
rs.close(); //關閉各物件
stmt.close();
conn.close();
out.println("完成修改！");
%>
<p></p>
<%
out.println("新的隨機密碼已寄至該電子郵件信箱！");
%>
<p></p>
<%
out.println("請用信件上的隨機密碼重新登入！並立即修改成屬於自己的密碼！");
}

catch(Exception ex)
{  
System.out.println(ex.toString());
}
response.setHeader("Refresh", "3; URL = login.jsp");
	session.removeAttribute("PASSWORD");
	session.removeAttribute("EMP_ID");
%>