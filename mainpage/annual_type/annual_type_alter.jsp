<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*"%> 

<%
request.setCharacterEncoding( "UTF-8");
String emp_id = (String)session.getAttribute("emp_id");
String leave_type = request.getParameter("input_type");
String hours = request.getParameter("input_hours");

String type = "";
String hr = "";

if(leave_type.equals("") || hours.equals("")){%>
<script>alert("未輸入變更名稱或時數"); 
window.history.back(-1); </script><%
}else{
%>
<%

float h1 =Float.parseFloat(hours);

session.setAttribute("h1",h1);
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
    
    String sql2="SELECT * FROM ANNUAL_LEAVE_HOURS_SETTING where leave_type='"+leave_type+"'";
	ResultSet rs2=stmt.executeQuery(sql2);
    if(rs2.next()){
		type=rs2.getString("leave_type");
		 }   rs2.close(); 
	stmt.close(); 
    conn.close();
        
}

catch(Exception e)
{
    out.println(e);
}


if(leave_type.equals(type)) {

}else{
%>
<script>
  alert("假別代碼不存在,請重新輸入!"); 
  window.history.back(-1);
</script>
<%
}
%>


<html>
<head>
    <title>修改員工年度假別時數確認</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
  <div class="span_title"><strong>修改假別時數確認</strong></div>
  <form action="annual_type_alter_cofirm.jsp" method="POST">
    <table class="table" cellpadding="6" style="width: 200px;" >
      <tr>
        <td>員工編號</td>
        <td><%=emp_id%></td>
      </tr>
      <tr>
        <td>假　　別</td>
        <td><%=leave_type%></td>
      </tr>
      <tr>
        <td>時　　數</td>
        <td><%=hours%></td>
      </tr>
      <tr align="center">
        <td colspan="2">
        <button class="btn btn-default btn-sm" type="SUBMIT">確認修改</button>
        <button class="btn btn-default btn-sm" type="BUTTON" onclick="self.history.back()">取消</button>
        </td>
      </tr>
    </table>
  </form>
</center>
</body>
</html>
<%}
session.setAttribute("leave_type",leave_type);
session.setAttribute("emp_id",emp_id);
%>