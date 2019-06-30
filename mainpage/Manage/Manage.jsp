<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <title>查詢員工資訊</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>

<body>
<center>
	<div class="span_title"><strong>查詢員工資訊</strong></div>
    <form action="Manage_Get.jsp" method="POST"> 
      <p>
        <div>員工編號：<input type="TEXT" name="emp_id" required="required"></div>
      </p><br/>
      <p>
        <button class="btn btn-danger btn-sm" type="Submit">查詢</button>
        <button class="btn btn-info btn-sm" type="RESET">重寫</button>
      </p>
    </form>
    <button class="btn btn-default btn-sm" onclick="self.location.href='Manage_add.jsp'">增加員工資料</button>
    
</center>
</body>
<%
	session.removeAttribute("emp_id");
	session.removeAttribute("emp_name");
	session.removeAttribute("sex");
	session.removeAttribute("english_name");
	session.removeAttribute("department");
	session.removeAttribute("occupation");
	session.removeAttribute("birth");
	session.removeAttribute("marital_status");
	session.removeAttribute("email");
	session.removeAttribute("manager");
	session.removeAttribute("date_joined");
	session.removeAttribute("levels_admin");
	session.removeAttribute("levels_boss");
	session.removeAttribute("levels");
	session.removeAttribute("date_left");
	session.removeAttribute("office_status");
%>
