<%@ page  contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String APPLICANT = (String)session.getAttribute("APPLICANT"); // 取得 detals_no 的信息
    String EMAIL = "";
   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="test"; 
        String password="test"; 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        String sql="SELECT EMAIL FROM STAFF_DATA WHERE EMP_NAME = "+"'"+APPLICANT+"'"; 
        ResultSet rs=stmt.executeQuery(sql);
        ResultSetMetaData rsmd = rs.getMetaData ();
		while(rs.next()) 
        {	
			EMAIL = rs.getString("EMAIL");
 }    
        rs.close();
        stmt.close(); 
        conn.close();

            
    }


    catch(Exception e)
    {
        //out.println("An exception occurred: " + e.getMessage());
        out.println(e);
    }
   	session.setAttribute("EMAIL",EMAIL);
   	response.setHeader("Refresh", "0; URL = check_SentEmail.jsp");
   	session.removeAttribute("APPLICANT");
   	out.print("寄信中...請稍等...");
%>