<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%> 

  <%
    //String loginURL = "http://localhost:8080/program/form.html";
 	//String welcomeURL = "http://localhost:8080/program/welcome.jsp";
   	String input_user = request.getParameter("input_user"); // 取得 name 的信息
   	String input_password = request.getParameter("input_password"); // 取得 password 的信息

   	String pass = "";
   	String levels = "";
   	String office_status = "";
   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="test"; 
        String password="test"; 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
        if(input_user.equals("")){
            stmt.close(); 
            conn.close();
        }
        
        else{
        String sql1="SELECT password FROM account_password WHERE emp_id = " + "'" + input_user + "'" ; 
        String sql2="SELECT levels,office_status FROM staff_data WHERE emp_id = " + input_user  ; 
        ResultSet rs=stmt.executeQuery(sql1); 
        

        
        if(rs.next())
        {
        	pass=rs.getString("password");
        }
        
        rs=stmt.executeQuery(sql2);
  
        if(rs.next())
        {
        	levels=rs.getString("levels").trim();
        	office_status=rs.getString("office_status").trim();
        }
        
        
        
        rs.close(); 
        stmt.close(); 
        conn.close();
        }
    }

    catch(Exception e)
    {
        out.println(e);
    }
    %><script Language="JavaScript"><%
    if( pass.equals(input_password)) { 
    	if(levels.equals("1") && office_status.equals("1")){
        	session.setAttribute("input_user", input_user);
        	session.setAttribute("input_password", input_password);
        	%>
    		  location.href= ('employee_firstpage.html');
    		<%
    	 }
    	else if(levels.equals("2") && office_status.equals("1")){
        	session.setAttribute("input_user", input_user);
        	session.setAttribute("input_password", input_password);
        	%>
        	location.href= ('boss_firstpage.html');
    		<%
    	}
    	else if(levels.equals("3") && office_status.equals("1")){
        	session.setAttribute("input_user", input_user);
        	session.setAttribute("input_password", input_password);
        	%>
        	location.href= ('admin_firstpage.html');
    		<%
    	}
    	else if(levels.equals("4") && office_status.equals("1")){
        	session.setAttribute("input_user", input_user);
        	session.setAttribute("input_password", input_password);
        	%>
        	location.href= ('adminboss_firstpage.html'); </script>
    		<%
    	}
    	else{
    	    %>
    		alert("查無此使用者，點擊返回登入畫面"); 
    		location.href= ('login.jsp');
    		<%
    	}
    }
    else{
        %>
		alert("使用者或密碼錯誤，請重新輸入！"); 
	 	location.href= ('login.jsp');
	 	<%
    }
    %></script>
