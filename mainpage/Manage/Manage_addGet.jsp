<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
  request.setCharacterEncoding( "UTF-8");
  int emp_id=(Integer)session.getAttribute("emp_id");
  String emp_name = request.getParameter("emp_name");
  String english_name = request.getParameter("english_name");
  String sex = request.getParameter("sex");
  String birth = request.getParameter("birth");
  String marital_status = request.getParameter("marital_status");
  String email = request.getParameter("email");
  String department = request.getParameter("department");
  String manager = request.getParameter("manager");
  String occupation = request.getParameter("occupation");
  String date_joined = request.getParameter("date_joined");
  String levels_admin_chk = request.getParameter("levels_admin_chk");
  String levels_boss_chk = request.getParameter("levels_boss_chk");
  String levels_admin="";
  String levels_boss="";
%>

<html>
<head>
  <title>新增員工資料確認</title>
  <link href="../../css/bootstrap.min.css" rel="stylesheet">
  <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
<div class="span_title"><strong>新增員工資料確認</strong></div>

  <form action="Manage_addCofirm.jsp" method="POST">
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
            <th>管理者設定</th>
            <td>
              <%
              if(levels_admin_chk!= null){
                levels_admin ="1";
                out.println("是");
              }else{
                levels_admin ="0";
                out.println("否");
              }
              %>
            </td>
            <th>主管設定</th>
            <td>
              <%
              if(levels_boss_chk!= null){
                levels_boss ="1";
                out.println("是");
              }else{
                levels_boss ="0";
                out.println("否");
              }
              %>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div id="form_footer">
      <button class="btn btn-danger btn-sm" type="SUBMIT">確認</button>
      <button class="btn btn-default btn-sm" type="BUTTON" onclick="javascript:history.back(1)">返回</button>
    </div>
  </form>

</center>



<script language="JavaScript">
           	var dt = new Date('<%=birth%>');
           	var year1 = dt.getFullYear();
           	var dt = new Date('<%=date_joined%>');
           	var year2 = dt.getFullYear();
        	var year=year2-year1;
   			if(year<=0){
   				alert('出生日期比到職日期晚');
           		window.history.go(-1);
   			}	
           	</script>  
           	


</body>
</html>

<%

  session.setAttribute("emp_name",emp_name);
  session.setAttribute("english_name",english_name);
  session.setAttribute("sex",sex);
  session.setAttribute("birth",birth);
  session.setAttribute("marital_status",marital_status);
  session.setAttribute("email",email);
  session.setAttribute("department",department);
  session.setAttribute("manager",manager);
  session.setAttribute("occupation",occupation);
  session.setAttribute("date_joined",date_joined);
  session.setAttribute("levels_admin",levels_admin);
  session.setAttribute("levels_boss",levels_boss);
%>