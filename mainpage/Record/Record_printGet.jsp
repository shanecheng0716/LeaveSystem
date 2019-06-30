<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String form[]=new String[20];
String sql="";
String sql2="";
int num=0;
String VERIFY_REASON="";

form[0] = request.getParameter("form_checkbox_1");
form[1] = request.getParameter("form_checkbox_2");
form[2] = request.getParameter("form_checkbox_3");
form[3] = request.getParameter("form_checkbox_4");
form[4] = request.getParameter("form_checkbox_5");

form[5] = request.getParameter("form_checkbox_6");
form[6] = request.getParameter("form_checkbox_7");
form[7] = request.getParameter("form_checkbox_8");
form[8] = request.getParameter("form_checkbox_9");
form[9] = request.getParameter("form_checkbox_10");

form[10] = request.getParameter("form_checkbox_11");
form[11] = request.getParameter("form_checkbox_12");
form[12] = request.getParameter("form_checkbox_13");
form[13] = request.getParameter("form_checkbox_14");
form[14] = request.getParameter("form_checkbox_15");

form[15] = request.getParameter("form_checkbox_16");
form[16] = request.getParameter("form_checkbox_17");
form[17] = request.getParameter("form_checkbox_18");
form[18] = request.getParameter("form_checkbox_19");
form[19] = request.getParameter("form_checkbox_20");

for(int i=0;i<form.length;i++){
	if(form[i]!=null){
		num = i;
		break;
	}
}
for(int j=num;j<form.length;j++){
	if(j==num){
		sql = "SELECT DETAILS_NO,FORM_HEAD_OF_PSEUDOMONAS.FORM_NO,APPLY_TIME,APPLICANT,LEAVES,START_TIME,END_TIME,HOURS,AGENT,REASON,VERIFY_REASON FROM FORM_HEAD_OF_PSEUDOMONAS,DETAILS_OF_PSEUDOMONAS WHERE (FORM_HEAD_OF_PSEUDOMONAS.FORM_NO =" +"'" +form[j] + "'" + " AND DETAILS_OF_PSEUDOMONAS.FORM_NO = "+"'"+ form[j]+"') ";
	}

	else if(form[j]!=null){
		sql2 = " OR (FORM_HEAD_OF_PSEUDOMONAS.FORM_NO = '"+form[j]+"'  AND DETAILS_OF_PSEUDOMONAS.FORM_NO = '"+form[j]+"')";
	}
	    sql = sql +sql2;
}



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
    
    ResultSet rs=stmt.executeQuery(sql); 

    session.setAttribute("sql",sql);
    
 %>   
    <HTML>
    <HEAD>
        <title>歷史假單</title>
        <link href="../../css/bootstrap.min.css" rel="stylesheet">
        <link href="../../css/style.css" rel="stylesheet">
    </HEAD>
    <body>
    <center>
     
     <form action="Record_outprint.jsp" method="post">    
    	<table class="table table-striped table-hover" cellpadding="6" style="width: 750px;">
    	  <thead>
    	    <tr align="center">
        	  <td></td>
        	  <td>表單編號</td>
        	  <td>申請時間</td>
        	  <td>申請人</td>
        	  <td>假別</td>
        	  <td>開始時間</td>
        	  <td>結束時間</td>
        	  <td>時數</td>
        	  <td>代理人</td>
        	  <td>事由</td>
        	  <td>核准或核退原因</td>
        	  <td></td>
            </tr>
          </thead>
    	  <tbody>
    	<%
    	//利用For迴圈配合PageSize屬性輸出一頁中的記錄
    	while(rs.next())
    	{
    	  %>	  
    	    <tr align="center">
    	      <td></td>
    	      <td><%=rs.getString("FORM_NO")%></td>
    	      <td><%=rs.getString("APPLY_TIME")%></td>
    	      <td><%=rs.getString("APPLICANT")%></td>
    	      <td><%=rs.getString("LEAVES")%></td>
    	      <td><%=rs.getString("START_TIME")%></td>
    	      <td><%=rs.getString("END_TIME")%></td>
    	      <td><%=rs.getString("HOURS")%></td>
    	      <td><%=rs.getString("AGENT")%></td>
    	      <td><%=rs.getString("REASON")%></td>
         	  <td><%VERIFY_REASON=rs.getString("VERIFY_REASON");
         	         if(VERIFY_REASON==null){
            	 		 out.print("無");
          			}
          			else{
          				out.print(VERIFY_REASON);
          		}
          %> </td>
    	    </tr>
          <%	    
    	    }
   	
%>
    	  </tbody>
        </table>
          <button class="btn btn-danger btn-sm" type="SUBMIT">確認</button>
          <button class="btn btn-default btn-sm" type="BUTTON" onclick="javascript:history.back(1)">返回</button>
    	</form>
    </center>
    </body>
    </HTML>  
    
    
   <% 
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
