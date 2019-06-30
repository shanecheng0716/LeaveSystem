<%@ page contentType="text/html; charset=UTF-8" 
  import="java.sql.*"%>
<% 
request.setCharacterEncoding( "UTF-8");
session.removeAttribute("EMAIL");
session.removeAttribute("FORM_NO");
session.removeAttribute("PSE_STATUS");
session.removeAttribute("VERIFY_REASON");
%> 
<%
ResultSet rs = null;
String STATUS = "";
String FORM_NO = "";
String MAN_NAME = "";
String INPUT_USER_value = (String)session.getAttribute("input_user");
  try{
    //連接資料庫(需要IP、PORT、DB_SID)
    Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
    String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
    
    //使用者帳號，密碼
    String user="test"; //帳號 
    String password="test"; //密碼 
    Connection conn= DriverManager.getConnection(url,user,password); 
    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    String sql1="SELECT EMP_NAME FROM STAFF_DATA WHERE EMP_ID = "+"'"+INPUT_USER_value+"'";
    ResultSet rs1=stmt.executeQuery(sql1);
    if(rs1.next()){
    	MAN_NAME = rs1.getString("EMP_NAME");
    }
  }
  catch(Exception e)
  {
      //out.println("An exception occurred: " + e.getMessage());
      out.println(e);
  }
  session.setAttribute("MAN_NAME",MAN_NAME );
  response.setHeader("Refresh", "0; URL = check_getleaveColumn.jsp");
    %>