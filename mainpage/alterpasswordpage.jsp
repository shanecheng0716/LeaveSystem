<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%> 


<%
//密碼修改-取得欄位值
     String old_password = request.getParameter("old_password");     
     String new_password = request.getParameter("new_password");
     String AffirmNewPassword = request.getParameter("AffirmNewPassword");
     String input_user=(String)session.getAttribute("input_user");
     String input_password=(String)session.getAttribute("input_password");
     
     if(old_password.equals(new_password)){%>
		<script>alert("新舊密碼不可相同，請重新輸入！"); 
	 	window.location='alterpassword.jsp'; </script>
	 	<%   	 
     }
     else if(!new_password.equals(AffirmNewPassword)){%>
		<script>alert("新密碼與二次確認密碼不相同，請重新輸入！"); 
	 	window.location='alterpassword.jsp'; </script>
	 	<%    	 
     }
     else if(!old_password.equals(input_password)){%>
		<script>alert("舊密碼錯誤，請重新輸入！"); 
	 	window.location='alterpassword.jsp'; </script>
	 	<%    	 
     }
     
     
     
     else if(old_password.equals(input_password) && new_password.equals(AffirmNewPassword)){ 
     	 try{
    	 	//連接資料庫(需要IP、PORT、DB_SID)
         	Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
         	String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
         	String user="test"; 
         	String password="test"; 
         	Connection conn= DriverManager.getConnection(url,user,password); 
         	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
         
         	String sql= "UPDATE ACCOUNT_PASSWORD SET PASSWORD = " +"'" + new_password + "'" + " WHERE PASSWORD=" + "'"+ old_password +"'" + "AND emp_id =" +"'" + input_user + "'"; 
         	ResultSet rs=stmt.executeQuery(sql); 
         
         	rs.close();	       
         	stmt.close();
         	conn.close();
         	
        	session.setAttribute("input_password", new_password);        	
	        %>
			<script>alert("密碼修改成功！"); 
		 	window.location='alterpassword.jsp'; </script>
		 	<%
     	}

     	catch(Exception e)
     	{
        	 //out.println("An exception occurred: " + e.getMessage());
         	out.println(e);
     	}
	 }
	 else{%>
		<script>alert("輸入有誤，請重新輸入！"); 
	 	window.location='alterpassword.jsp'; </script>
	 	<%
	 }
%>

	