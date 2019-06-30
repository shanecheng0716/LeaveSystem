<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
  request.setCharacterEncoding( "UTF-8");
  String emp_id = request.getParameter("emp_id");
  String emp_id_sql="";

  String emp_name ="";
  String english_name ="";
  String sex ="";
  String birth ="";
  String marital_status ="";
  String email ="";
  String department ="";
  String manager ="";
  String occupation ="";
  String office_status ="";
  String date_joined ="";
  String date_left ="";
  String levels ="";

  String levels_admin="";
  String levels_boss="";
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
    
    String sql="SELECT * FROM STAFF_DATA  WHERE emp_id = "+ emp_id; //資料庫語法
    ResultSet rs=stmt.executeQuery(sql); 
    
    //資料庫欄位顯示，抓不夠會直接抓下一筆，抓太多第一筆就會出錯
    if(rs.next()) 
    {
      emp_id_sql = rs.getString("emp_id");
      emp_name = rs.getString("emp_name");
      english_name = rs.getString("english_name");
      sex = rs.getString("sex");
      birth =rs.getString("birth");
      marital_status = rs.getString("marital_status").trim();
      email = rs.getString("email");
      department = rs.getString("department");
      manager =rs.getString ("manager");
      occupation = rs.getString("occupation");
      office_status = rs.getString("office_status").trim();
      date_joined = rs.getString("date_joined");
      date_left = rs.getString("date_left");
      levels = rs.getString("levels").trim();
    }
    if(emp_id.equals(emp_id_sql)){

    }else{
      %>
      <script>
        alert("查無此員工，請重新輸入！"); 
        window.history.back(-1);
      </script>
      <%
    }
    rs.close();
    stmt.close(); 
    conn.close();
  }

  catch(Exception e)
  {
    out.println(e);
  }
%>

<%
  if(levels.equals("4")){
    levels_admin ="1";
    levels_boss="1";
  }else if(levels.equals("3")){
    levels_admin ="1";
    levels_boss="0";
  }else if(levels.equals("2")){
    levels_admin ="0";
    levels_boss="1";
  }else{
    levels_admin ="0";
    levels_boss="0";
  } 
%>


<html>
<head>
    <title>查詢員工資料</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
<div class="span_title"><strong>查詢員工資料</strong></div>
  <form action="Manage_alter.jsp" method="POST">
    <div id="form_content-body">
      <table class="table table-striped" cellpadding="6" style="width: 600px;" >
        <thead>
          <tr>
            <th style="width: 100px;"></th>
            <th style="width: 200px;"></th>
            <th style="width: 100px;">員工編號</th>
            <th style="width: 200px;">
              <% out.println(emp_id); %>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th>姓名</th>
            <td>
              <% out.println(emp_name); %>
            </td>
            <th>英文姓名</th>
            <td>
              <% out.println(english_name); %>
            </td>
          </tr>

          <tr>
            <th>性別</th>
            <td>
              <%
              if(sex.equals("0")){
                out.println("女");
              }else{
                out.println("男");
              }
              %>
            </td>
            <th>出生日期</th>
            <td>
              <% out.println(birth); %>
            </td>
          </tr>

          <tr>
            <th>婚姻狀態</th>
            <td>
              <%
              if(marital_status.equals("0")){
                out.println("未婚");
              }else{
                out.println("已婚");
              }
              %>
            </td>
            <th>電子信箱</th>
            <td>
              <% out.println(email); %>
            </td>
          </tr>

          <tr>
            <th>部門</th>
            <td>
              <% out.println(department); %>
            </td>
            <th>主管</th>
            <td>
              <% out.println(manager); %>
            </td>
          </tr>

          <tr>
            <th>職稱</th>
            <td>
              <% out.println(occupation); %>
            </td>
            <th>到職日期</th>
            <td>
              <% out.println(date_joined); %>
            </td>
          </tr>

          <tr>
            <th>在職狀態</th>
            <td colspan="3">
              <%
              if(office_status.equals("0")){
                out.println("已離職，日期：");
                out.println(date_left);
              }else{
                out.println("在職中");
              }
              %>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div id="form_footer">
    <%if(office_status.equals("1")){ %>
      <button class="btn btn-warning btn-sm" type="SUBMIT">修改</button><button class="btn btn-default btn-sm" type="BUTTON" onclick="self.location.href='Manage.jsp'">修改</button>
      <% 
		} 
		else{ %>
		
		        <button class="btn btn-default btn-sm" type="BUTTON" onclick="self.location.href='Manage.jsp'">返回</button>
		   
        <%
        } %>
	</div>
</form>
</center>
</body>
</html>
<%
    session.setAttribute("emp_id",emp_id);
    session.setAttribute("emp_name",emp_name);
    session.setAttribute("english_name",english_name);
    session.setAttribute("sex",sex);
    session.setAttribute("birth",birth);
    session.setAttribute("marital_status",marital_status);
    session.setAttribute("email",email);
    session.setAttribute("department",department);
    session.setAttribute("manager",manager);
    session.setAttribute("occupation",occupation);
    session.setAttribute("office_status",office_status);
    session.setAttribute("date_joined",date_joined);
    session.setAttribute("date_left",date_left);
    session.setAttribute("levels_admin",levels_admin);
    session.setAttribute("levels_boss",levels_boss);
%>