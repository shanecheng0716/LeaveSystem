<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%> 

  <%
 
    //String loginURL = "http://localhost:8080/program/form.html";
 	//String welcomeURL = "http://localhost:8080/program/welcome.jsp";
   	String FORM_NO_value = (String)session.getAttribute("FORM_NO");
   	String VERIFY_REASON = request.getParameter("VERIFY_REASON");
   	String HOURS_value = (String)session.getAttribute("HOURS");
   	String EMP_ID_value = (String)session.getAttribute("EMP_ID");
   	String LEAVES_value = (String)session.getAttribute("LEAVES");
   	float HOURS = Float.parseFloat(HOURS_value);
   	String APPLICANT = "";
	String PSE_STATUS= "1";
	float USE_HOURS = 0;
	float FN_HOURS = 0;
   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="test"; 
        String password="test"; 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
       
        String sql="UPDATE FORM_HEAD_OF_PSEUDOMONAS SET FORM_HEAD_OF_PSEUDOMONAS.PSE_STATUS = '1' WHERE FORM_NO = "+"'"+FORM_NO_value+"'"; 
        ResultSet rs=stmt.executeQuery(sql); 
        String sql3="UPDATE DETAILS_OF_PSEUDOMONAS SET VERIFY_REASON = "+"'"+ VERIFY_REASON +"'" +" WHERE FORM_NO = "+"'"+FORM_NO_value+"'";
        ResultSet rs3=stmt.executeQuery(sql3);
        String sql2="SELECT APPLICANT FROM FORM_HEAD_OF_PSEUDOMONAS WHERE FORM_NO = "+"'"+FORM_NO_value+"'";
        ResultSet rs2=stmt.executeQuery(sql2);
        if(rs2.next()){
        	APPLICANT = rs2.getString("APPLICANT");
        }
        String sql4="SELECT FN_HOURS,USE_HOURS FROM ANNUAL_LEAVE_HOURS_SETTING WHERE LEAVE_TYPE = "+"'"+ LEAVES_value +"' AND EMP_ID = "+"'"+ EMP_ID_value +"'";
        ResultSet rs4=stmt.executeQuery(sql4);
        if(rs4.next()){
        	USE_HOURS = rs4.getFloat("USE_HOURS");
        	FN_HOURS = rs4.getFloat("FN_HOURS");
        }
        

        
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
    session.setAttribute("APPLICANT",APPLICANT);
    session.setAttribute("VERIFY_REASON",VERIFY_REASON);
    session.setAttribute("PSE_STATUS",PSE_STATUS);
	FN_HOURS = FN_HOURS - HOURS;
	USE_HOURS = USE_HOURS + HOURS;
	session.setAttribute("FN_HOURS",FN_HOURS);
	session.setAttribute("USE_HOURS",USE_HOURS);
%>
<script>alert("完成審核!"); 
	 window.location='check_Upatevalue.jsp'; </script>