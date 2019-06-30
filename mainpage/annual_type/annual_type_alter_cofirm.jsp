<%@ page contentType="text/html;charset=UTF-8"%> 
<%@ page import="java.sql.*"%> 

<%request.setCharacterEncoding( "UTF-8");
String emp_id = (String)session.getAttribute("emp_id");
String leave_type = (String)session.getAttribute("leave_type");
float h1 = (Float)session.getAttribute("h1");
float fn_hours = 0;
float use_hours = 0;

    try 
    {  
  
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
        
        //使用者帳號，密碼
        String user="test"; //帳號 
        String password="test"; //密碼 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
        String sql2="SELECT *  FROM ANNUAL_LEAVE_HOURS_SETTING where leave_type='"+leave_type+"'";
    	ResultSet rs2=stmt.executeQuery(sql2);
        if(rs2.next())
  		 {
   		leave_type=rs2.getString("leave_type");
   		fn_hours=rs2.getFloat("FN_HOURS");
   		use_hours=rs2.getFloat("USE_HOURS");
  		 }   rs2.close(); 
        
  		if(h1<use_hours){
  			%>
  			<script>alert("修改時數不可比已使用時數少"); 
  			top.location='annual_type_get.jsp'; </script>
  			<% 		
  			}else {
  			fn_hours=h1-use_hours;
        String sql="UPDATE ANNUAL_LEAVE_HOURS_SETTING SET fn_hours = " +"'" + fn_hours + "', hours = "+"'" + h1 + "' where emp_id = " +"'" + emp_id + "' AND leave_type = " + "'" +leave_type+ "'"; //資料庫語法
        ResultSet rs=stmt.executeQuery(sql); 
        
        //資料庫欄位顯示，抓不夠會直接抓下一筆，抓太多第一筆就會出錯
        rs.close(); 
        stmt.close(); 
        conn.close();
            
    }
    }
    catch(Exception e)
    {
        //out.println("An exception occurred: ");
        out.println(e);
    }

%> 
<script>alert("假別時數修改成功!"); 
  location.href='annual_type_get.jsp'; </script>