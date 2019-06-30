<%@ page contentType="text/html;charset=UTF-8"%> 
<%@ page import="java.sql.*"%> 

<%
String emp_id = (String)session.getAttribute("emp_id");
String leave_type = (String)session.getAttribute("leave_type");
float h1 = (Float)session.getAttribute("h1");
int annual_no = (Integer)session.getAttribute("annual_no");
annual_no = annual_no +1;


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
        
        String sql="INSERT INTO ANNUAL_LEAVE_HOURS_SETTING (emp_id,leave_type,hours,annual_no,fn_hours,use_hours) VALUES (" + "'" +emp_id+  "','" +leave_type+ "','" + h1 +"','" +annual_no+ "','0','0')"; //資料庫語法
        ResultSet rs=stmt.executeQuery(sql); 
        
        //資料庫欄位顯示，抓不夠會直接抓下一筆，抓太多第一筆就會出錯
        rs.close(); 
        stmt.close(); 
        conn.close();
            
    }

    catch(Exception e)
    {
        //out.println("An exception occurred: ");
        out.println(e);
    }

%> 
<script>alert("假別時數新增成功!"); 
	 location.href='annual_type_get.jsp'; </script>