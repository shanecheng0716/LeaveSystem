<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;">
	<title>系統登入</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
	<style>
		.bg{
			background-image: url(../image/logo.png);
			background-repeat: no-repeat;
		    background-color: #ffffff;
		    background-position: center top;
		}
	</style>
	
</head>
<body class="bg">
<% session.invalidate(); %>
<center>
	<div class="span_title"><strong>系統登入</strong></div>
	<form action="login_get.jsp" method="POST">

        <p><span style="color: white;"><strong>帳號：</strong></span><input type="TEXT" name="input_user"></p>
        <p><span style="color: white;"><strong>密碼：</strong></span><input type="PASSWORD" name="input_password"></p>

		<p>
		  <button class="btn btn-info btn-sm" type="reset">清空</button>
		  <button class="btn btn-danger btn-sm" type="submit">登入</button>
		</p>
	</form>
    <!-- Button trigger modal -->
	<button class="btn btn-default btn-sm" data-toggle="modal" data-target="#forget">
	  忘記密碼
	</button>


	<!-- Modal -->
	<div class="modal fade" id="forget" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	       <!--  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--> 
	        <h4 class="modal-title" id="myModalLabel">忘記密碼</h4>
	      </div>
	        <form action="password_getData.jsp" method="post">
		      <div class="modal-body">
				  <p>帳號：<input type="TEXT" name="Name" required="required"></p>
		          <p>信箱：<input type="email" name="myEmail" required="required"></p>
		          <p>出生日期:<input type = "text" name = "myBirth" required="required" placeholder = "ex:2000-01-01"></p>
		          <p style="color: gray;font-size: 10px;">請輸入註冊時的信箱(請包含@)</p>
		      </div>
		      <div class="modal-footer">
				  <button class="btn btn-info btn-sm" type="reset">清空</button>
				   <input type="submit" class="btn" onsubmint="javascript:location.href='password_getData.jsp'"value="寄發審核信件">
		      </div>
			</form>
	    </div>
	  </div>
	</div>
    <script src="../../js/jquery.min.js"></script>
    <script src="../../js/bootstrap.min.js"></script>
</center>
</body>
</html>