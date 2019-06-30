<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>修改密碼</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">

    </script>

</head>
<body>

<center>
    <div class="span_title"><strong>修改密碼</strong></div>

    <form action="alterpasswordpage.jsp" method="POST">
  	     <p>舊密碼：<input type="PASSWORD" name="old_password" required="required"></p>
         <p>新密碼：<input type="PASSWORD" name="new_password" required="required"></p>
         <p>再確認：<input type="PASSWORD" name="AffirmNewPassword" required="required"></p>
         <p><input type="SUBMIT" class="btn" value="確認"></p>
    </form>
</center>
</body>
</html>