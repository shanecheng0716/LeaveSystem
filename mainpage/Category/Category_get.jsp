<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=utf-8");
String input_type = request.getParameter("input_type"); // 取得 name 的信息
String input_no = request.getParameter("input_no");
String tp="";
String no="";
String sql1="";
String sql2="";
String sql="";
%>

<html>
<head>
    <title>新增假別確認</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
  <div class="span_title"><strong>新增假別確認</strong></div>
  <form action="Category_confirm.jsp" method="POST">
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
        
        
    sql1="SELECT *  FROM type_of_leave where leave_no='"+input_no+"'";
    ResultSet rs1=stmt.executeQuery(sql1);

    if(rs1.next())
    {
        tp=rs1.getString("leave_type");
        no=rs1.getString("leave_no");
    }
    rs1.close();
    sql="SELECT *  FROM type_of_leave where leave_type='"+input_type+"'";
    ResultSet rs=stmt.executeQuery(sql);

    if(rs.next())
    {
        tp=rs.getString("leave_type");
        no=rs.getString("leave_no");
    }
    rs.close();
    sql2="SELECT *  FROM type_of_leave where leave_type='"+input_type+"' AND leave_no='"+input_no+"'";
    ResultSet rs2=stmt.executeQuery(sql2);

    if(rs2.next())
        {
          tp=rs2.getString("leave_type");
          no=rs2.getString("leave_no");
        }
    rs2.close();


    if(no.equals(input_no)) {
      %>
      <script>
        alert("假別代碼已存在!");
        location.href="Category.jsp";
      </script>
      <%
        }else if(tp.equals(input_type)){
      %>
      <script>
        alert("假別名稱已存在!"); 
        location.href="Category.jsp";
      </script>
      <%
        }else if(no.equals(input_no)&&tp.equals(input_type)){
      %>
      <script>
        alert("假別名稱和假別代碼已存在!"); 
        location.href="Category.jsp";
      </script>
      <%
        }else{
      stmt.close(); 
      conn.close();
    }
  }
  catch(Exception e)
  {
    out.println(e);
  }
%>
    <table class="table" cellpadding="6" style="width: 300px;" >
      <tr>
        <td>假別名稱</td>
        <td><% out.println(input_type); %></td>
      </tr>
      <tr>
        <td>假別代碼</td>
        <td><% out.println(input_no); %></td>
      </tr>
      <tr>
        <td colspan="2">
          <button class="btn btn-default btn-sm" type="SUBMIT">送出</button>
          <button class="btn btn-default btn-sm" type="BUTTON" onclick="self.history.back()">取消</button>
        </td>
      </tr>
    </table>
  </form>
</center>
<%
session.setAttribute("input_no",input_no);
session.setAttribute("input_type",input_type);

%>

</body>
</html>
