<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <title>查詢員工年度假別</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>

<body>
<center>
	<div class="span_title"><strong>查詢員工年度假別</strong></div>
    <form action="annual_type_get.jsp" method="POST"> 
      <p>
        <div>員工編號：<input type="TEXT" name="emp_id" required="required"></div>
      </p>
      <br/>
      <p>
        <button type="Submit" class="btn btn-danger btn-sm">查詢</button>
        <button type="RESET" class="btn btn-info btn-sm">重寫</button>
      </p>
    </form>
    
</center>

<%
	session.removeAttribute("emp_id");
	session.removeAttribute("leave_type");
	session.removeAttribute("hours");
	session.removeAttribute("annual_no");
	session.removeAttribute("fn_hours");
	session.removeAttribute("use_hours");
%>
</body>
