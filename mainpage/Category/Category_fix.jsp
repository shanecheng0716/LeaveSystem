<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  <%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

request.setCharacterEncoding("UTF-8");

String input_no = request.getParameter("fix_no");
String tp="";
String no="";

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
    
    String sql="SELECT *  FROM type_of_leave where leave_no='"+input_no+"'";
    ResultSet rs=stmt.executeQuery(sql);

    if(rs.next()){
      tp=rs.getString("leave_type");
      no=rs.getString("leave_no");
    }
    rs.close();//資料庫語法
    stmt.close(); 
    conn.close();
 
  }

  catch(Exception e)
  {
      //out.println("An exception occurred: " + e.getMessage());
      out.println(e);
  }

%> 


<html>
<head>
    <title>變更假別確認</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
  <div class="span_title"><strong>變更假別確認</strong></div>
  <form action="Category_fixsubmit.jsp" method="POST">
    <table class="table" cellpadding="6" style="width: 300px;" >
      <tr align="center">
        <td class="warning" colspan="2">選中的資料如下</td>
      </tr>
      <tr align="center">
        <td>
          <%=no%>
        </td>
      </tr>
        <td>
          <%=tp%>
        </td>

      <tr align="center">
        <td class="warning" colspan="2">請輸入變更項目(擇一)</td>
      </tr>

      <tr>
        <td>假別名稱</td>
        <td><input name="input_type2"  pattern="[\u4E00-\u9FA5]+"   title="請輸入中文" ></td>
      </tr>

      <tr>
        <td>假別代碼</td>
        <td><input name="input_no2" pattern="[0-9]+"   title="請輸入數字" ></td>
      </tr>
      <tr>
        <td colspan="2">
          <button class="btn btn-default btn-sm" type="SUBMIT">修改名稱</button>
          <button class="btn btn-default btn-sm" type="button" onClick="this.form.action='Category_fixsubmit2.jsp';this.form.submit();">修改代碼</button>
          <button class="btn btn-default btn-sm" type="button" onClick="this.form.action='Category_fixdelete.jsp';this.form.submit();">刪除代碼</button>
          <button class="btn btn-default btn-sm" type="button" onclick="self.history.back()">返回</button>
        </td>
      </tr>
    </table>
  </form>

</center>

<%
session.setAttribute("input_no",no);
session.setAttribute("input_type",tp);

%>
</body>
</html>
