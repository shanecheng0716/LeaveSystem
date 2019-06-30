<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ page import="java.sql.*"%> 

<% request.setCharacterEncoding( "UTF-8");
String emp_id = (String)session.getAttribute("emp_id");
String leave_type = request.getParameter("input_type");
String hours = request.getParameter("input_hours");

String sql_leave_type="";

float h1 =Float.parseFloat(hours);
session.setAttribute("h1",h1);

try 
{  

    //連接資料庫(需要IP、PORT、DB_SID)
    Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
    String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
    
    //使用者帳號，密碼
    String user="test"; //帳號 
    String password="test"; // 密碼 
    Connection conn= DriverManager.getConnection(url,user,password); 
    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
    
    String sql="SELECT leave_type FROM ANNUAL_LEAVE_HOURS_SETTING WHERE emp_id ="+"'"+emp_id+"' AND leave_type="+"'"+leave_type+"'"; //資料庫語法
    ResultSet rs=stmt.executeQuery(sql); 
    
    if(rs.next()){
    	sql_leave_type=rs.getString("leave_type");
    }
    
    
    //資料庫欄位顯示，抓不夠會直接抓下一筆，抓太多第一筆就會出錯
    rs.close(); 
    stmt.close(); 
    conn.close();
    
    if(sql_leave_type.equals(leave_type)) {%>
	 <script>alert("假別已存在!"); 
	   window.history.back(-1); </script><%
    }	   
else{

	   
rs.close();				//資料庫語法
stmt.close(); 
conn.close();

}
}
catch(Exception e)
{
//out.println("An exception occurred: " + e.getMessage());
out.println(e);
}
%>

<html>
<head>
    <title>新增員工年度假別時數確認</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
  <div class="span_title"><strong>新增假別時數確認</strong></div>
　<form action="annual_type_add_cofirm.jsp" method="POST">
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
        <button class="btn btn-default btn-sm" type="SUBMIT">新增</button>
        <button class="btn btn-default btn-sm" type="BUTTON" onclick="self.history.back()">取消</button>
        </td>
      </tr>
    </table>
　　</form>
</center>
</body>
</html>
<%
session.setAttribute("leave_type",leave_type);

%>