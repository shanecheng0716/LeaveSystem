<%@ page contentType="text/html; charset=UTF-8" 
  import="java.sql.*"%>
<%
	String EMP_ID_value = request.getParameter("Name");
	String EMAIL_value = request.getParameter("myEmail");
	String BIRTH_value= request.getParameter("myBirth");
	String BIRTH = null;
	//out.print(BIRTH_value);
	
ResultSet rs = null;
try{
  //連接資料庫(需要IP、PORT、DB_SID)
  Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
  String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
  
  //使用者帳號，密碼
  String user="test"; //帳號 
  String password="test"; //密碼 
  Connection conn= DriverManager.getConnection(url,user,password); 
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
  String sql="SELECT BIRTH FROM STAFF_DATA WHERE STAFF_DATA.EMP_ID = "+"'"+EMP_ID_value+"'AND STAFF_DATA.EMAIL = "+"'"+EMAIL_value+"'";
  rs=stmt.executeQuery(sql);   
//建立ResultSet(結果集)物件，並執行SQL敘述
if(rs.next()) 
{
	BIRTH = rs.getString("BIRTH");
}
rs.close(); //關閉各物件
stmt.close();
conn.close();
}

catch(Exception ex)
{  
System.out.println(ex.toString());
}
session.setAttribute("BIRTH",BIRTH);
session.setAttribute("EMP_ID",EMP_ID_value);
session.setAttribute("EMAIL",EMAIL_value);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link type="text/css" rel="stylesheet" href="../../css/style.css">
    <title>審核假單</title>
</head>
<body>
<%String birth=(String)session.getAttribute("BIRTH"); 
%>
<%
if(birth==null){%>
	<script type="text/javascript">
	alert("帳號或電子郵件有錯誤,請重新確認!"); 
	 window.location='login.jsp';
	</script>
<%}
else if(BIRTH_value!=null){
if(BIRTH_value.equals(birth)){%>
	<script type="text/javascript">
	alert("輸入正確!"); 
	 window.location='password_SentEmail.jsp';
	</script>
<%}
else{%>
	<script type="text/javascript">
	alert("您的出生年月日有錯誤,請重新確認!"); 
	 window.location='login.jsp';
	</script>
<%}
    }%>
</body>
</html>