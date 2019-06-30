<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%> 

  <%
 
    //String loginURL = "http://localhost:8080/program/form.html";
 	//String welcomeURL = "http://localhost:8080/program/welcome.jsp";
	String FORM_NO_value = (String)session.getAttribute("FORM_NO");
   	String VERIFY_REASON = request.getParameter("VERIFY_REASON");
	String APPLICANT = "";
   	String HOURS_value = (String)session.getAttribute("HOURS");
   	String EMP_ID_value = (String)session.getAttribute("EMP_ID");
   	String LEAVES_value = (String)session.getAttribute("LEAVES");
	String PSE_STATUS_value= (String)session.getAttribute("PSE_STATUS");
   	float HOURS = Float.parseFloat(HOURS_value);
	float FN_HOURS = 0;
	float USE_HOURS = 0;
	ResultSet rs = null;
	try 
    { 
   		if(VERIFY_REASON.equals("")){%>

     	 <script>alert("核退原因未填寫!"); 
	 	window.location='javascript:history.back(1).jsp'; </script>
	 	<%
		}	 
   		
   		else{
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="test"; 
        String password="test"; 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
       if(PSE_STATUS_value.equals("1")){
    	   String sql1="SELECT FN_HOURS,USE_HOURS FROM ANNUAL_LEAVE_HOURS_SETTING WHERE LEAVE_TYPE = "+"'"+ LEAVES_value +"' AND EMP_ID = "+"'"+ EMP_ID_value +"'";
    	   ResultSet rs1=stmt.executeQuery(sql1);
           if(rs1.next()){
           	USE_HOURS = rs1.getInt("USE_HOURS");
           	FN_HOURS = rs1.getInt("FN_HOURS");
           }
           FN_HOURS = FN_HOURS - HOURS;
       	   USE_HOURS = USE_HOURS + HOURS;
       	   session.setAttribute("FN_HOURS",FN_HOURS);
       	   session.setAttribute("USE_HOURS",USE_HOURS);
           String sql="UPDATE FORM_HEAD_OF_PSEUDOMONAS SET FORM_HEAD_OF_PSEUDOMONAS.PSE_STATUS = '2' WHERE FORM_NO = "+"'"+FORM_NO_value+"'";
           rs=stmt.executeQuery(sql);
           String sql3="UPDATE DETAILS_OF_PSEUDOMONAS SET VERIFY_REASON = "+"'"+ VERIFY_REASON +"'" +" WHERE FORM_NO = "+"'"+FORM_NO_value+"'";
           ResultSet rs3=stmt.executeQuery(sql3);
           String sql2="SELECT APPLICANT FROM FORM_HEAD_OF_PSEUDOMONAS WHERE FORM_NO = "+"'"+FORM_NO_value+"'";
           ResultSet rs2=stmt.executeQuery(sql2); 
           if(rs2.next()) 
           {
           	APPLICANT = rs2.getString("APPLICANT");
           }
           session.setAttribute("VERIFY_REASON",VERIFY_REASON);
           %>
<script> alert("完成審核!");
      	 window.location='check_Upatevalue.jsp'; </script><%
       }
       else{
        String sql="UPDATE FORM_HEAD_OF_PSEUDOMONAS SET FORM_HEAD_OF_PSEUDOMONAS.PSE_STATUS = '2' WHERE FORM_NO = "+"'"+FORM_NO_value+"'";
        rs=stmt.executeQuery(sql);
        String sql3="UPDATE DETAILS_OF_PSEUDOMONAS SET VERIFY_REASON = "+"'"+ VERIFY_REASON +"'" +" WHERE FORM_NO = "+"'"+FORM_NO_value+"'";
        ResultSet rs3=stmt.executeQuery(sql3);
        String sql2="SELECT APPLICANT FROM FORM_HEAD_OF_PSEUDOMONAS WHERE FORM_NO = "+"'"+FORM_NO_value+"' ";
        ResultSet rs2=stmt.executeQuery(sql2); 
        if(rs2.next()) 
        {
        	APPLICANT = rs2.getString("APPLICANT");
        }
        session.setAttribute("VERIFY_REASON",VERIFY_REASON);
        %>

       <script>alert("完成核退!"); 
       	 window.location='check_getEmail.jsp'; </script>
       <% 
       }
        
        //顯示
        rs.close(); 
        stmt.close(); 
        conn.close();
        
        
        session.setAttribute("APPLICANT",APPLICANT);
        session.setAttribute("PSE_STATUS",PSE_STATUS_value);
     
   		}
    }
    catch(Exception e)
    {
        //out.println("An exception occurred: " + e.getMessage());
        out.println(e);
    }
   
%>
