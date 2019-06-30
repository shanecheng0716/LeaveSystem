<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<html>
<head>
  <title>註銷頁面</title>
  <link type="text/css" rel="stylesheet" href="../../css/style.css">
  
</head>
<body> 
  <%
   response.setHeader("refresh", "1; URL = login.jsp");  // 定時跳轉
   session.invalidate(); // 註銷 session 
  %>
<center>
  <h3>你已經成功退出本系統</h3>
  <h3>如果沒有成功跳轉 請點<a href="login.jsp" target="firstpage">這裡</a></h3>
</center>
</body>
</html>