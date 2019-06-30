<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Scanner"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
  request.setCharacterEncoding( "UTF-8");
String department="";
if(request.getParameter("input_department")!=null){
    department = request.getParameter("input_department");
}
else{
	department="";
}
  int RowCount = 0; //ResultSet的記錄筆數
  ResultSet rs4 = null;

  String form_no ="";
  Date apply_time =null;
  String applicant ="";
  String agent ="";
  String pse_status="";
  String dateField="";

  String []data =null;
  String data_sql="";
  
  SimpleDateFormat sdf = new SimpleDateFormat("MM"); //日期格式
  SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  Calendar calendar = Calendar.getInstance();
%>

<%
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
    
    
    if(department==""){
    	String sql1="SELECT apply_time,applicant,agent FROM FORM_HEAD_OF_PSEUDOMONAS WHERE extract(month from APPLY_TIME)=" + sdf.format(calendar.getTime());
        rs4=stmt.executeQuery(sql1);
        
        ResultSetMetaData rsmd4 = rs4.getMetaData ();
        int columnCount4 = rsmd4.getColumnCount ();
        String[] columnLabels4 = new String[columnCount4];
        int[] columnWidths4 = new int[columnCount4];
        for (int i = 1; i <= columnCount4; ++i) {
            columnLabels4[i-1] = rsmd4.getColumnLabel (i);
            columnWidths4[i-1] = Math.max (columnLabels4[i-1].length(),
                                          rsmd4.getColumnDisplaySize (i));
        }

        RowCount = rs4.getRow(); //取得ResultSet中記錄的筆數
        
    }
    
    
    else{
    
    String sql3="SELECT emp_name FROM STAFF_DATA WHERE department =" + "'" + department + "'";
    ResultSet rs3=stmt.executeQuery(sql3);
    
    ResultSetMetaData rsmd3 = rs3.getMetaData();      
    int columnCount3 = rsmd3.getColumnCount(); //取得欄位數 
    rs3.last(); //把rs指向最後一筆 
    //rs.getRow():取出目前所在的那一筆數 
    data = new String[rs3.getRow()*columnCount3]; 
    rs3.beforeFirst(); //再把rs指回最初的位置 
    
    
    		for(int i=0;rs3.next(); i++) { 
                for(int j=0; j<columnCount3; j++) { 
    			//getColumnName(int column) : get the designated column's name 
    					data[(i*columnCount3)+j] = rs3.getString(rsmd3.getColumnName(j+1)); 
               		}
    			}
    
    
			for(int i=0; i<data.length; i++){
				if((i+1)==data.length){
	  				data_sql= data_sql + " applicant = " + "'" + data[i] + "')";
					}
				else{
					data_sql= data_sql +" applicant = " + "'" + data[i] + "'" + " OR ";
					}
				} 
			
	String sql4="SELECT apply_time,applicant,agent FROM FORM_HEAD_OF_PSEUDOMONAS WHERE (extract(month from APPLY_TIME)=" + sdf.format(calendar.getTime()) + ") AND (";
	sql4=sql4+data_sql;
	rs4=stmt.executeQuery(sql4);
    
    ResultSetMetaData rsmd4 = rs4.getMetaData ();
    int columnCount4 = rsmd4.getColumnCount ();
    String[] columnLabels4 = new String[columnCount4];
    int[] columnWidths4 = new int[columnCount4];
    for (int i = 1; i <= columnCount4; ++i) {
        columnLabels4[i-1] = rsmd4.getColumnLabel (i);
        columnWidths4[i-1] = Math.max (columnLabels4[i-1].length(),
                                      rsmd4.getColumnDisplaySize (i));
    }

    RowCount = rs4.getRow(); //取得ResultSet中記錄的筆數
    
    
    }
%>

<html>
<head>
    <title>近期休假人員</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">

</head>
<body onload="thisMonth()">
<center>
<div class="span_title"><strong>近期休假人員</strong></div>
    
    <table class="table" cellpadding="6" style="width: 450px;" >
      <tr align="center">
        <td>申請時間</td>
        <td>申請人</td>
        <td>代理人</td>
      </tr>
    <%
        while(rs4.next()){
        %>
        
            <tr align="center">
                <td> <%apply_time=rs4.getDate("apply_time");
                out.print(sdf2.format(apply_time)); %></td>
                <td> <%=applicant=rs4.getString("applicant") %></td>
                <td> <%=agent=rs4.getString("agent") %></td>
            </tr>
        <%
        }
    %>
    </table>

	    <%

	    rs4.close();
        stmt.close(); 
        conn.close();
  }

  catch(Exception e)
  {
    out.println(e);
  }

%>
            <form action="admin_department_listMonthly.jsp" method="post">
            <select name="input_department">
              <option value="">所有人員</option>
              <option value="資料庫">資料庫</option>
              <option value="網頁">網頁</option>
              <option value="美工">美工</option>
            </select>
             <button class="btn btn-danger btn-sm" type="submit">查詢</button>
             </form>

</center>
</body>
</html>