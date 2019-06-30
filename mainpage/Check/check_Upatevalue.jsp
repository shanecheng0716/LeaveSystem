<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%> 
	<%
   	String HOURS_value = (String)session.getAttribute("HOURS");
   	String EMP_ID_value = (String)session.getAttribute("EMP_ID");
   	String LEAVES_value = (String)session.getAttribute("LEAVES");
	Float USE_HOURS_value = (Float)session.getAttribute("USE_HOURS");
   	Float FN_HOURS_value = (Float)session.getAttribute("FN_HOURS");
   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="test"; 
        String password="test"; 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 

        String sql = "update annual_leave_hours_setting set fn_hours = "+"'"+ FN_HOURS_value +"',use_hours  = "+"'"+ USE_HOURS_value +"' where emp_id = "+"'"+ EMP_ID_value +"' and leave_type = "+"'"+ LEAVES_value +"'";
        ResultSet rs=stmt.executeQuery(sql);
      
        //顯示 
        rs.close(); 
        stmt.close(); 
        conn.close();      
    }
    catch(Exception e)
    {
        //out.println("An exception occurred: " + e.getMessage());
        out.println(e);
    }

%>
<script> 
	 window.location='check_getEmail.jsp'; </script>%>