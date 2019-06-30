<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
  ResultSet rs=null;
%>
<%
  String levels="1";

  String emp_id=(String)session.getAttribute("emp_id");
  String marital_status=(String)session.getAttribute("marital_status");
  String department=(String)session.getAttribute("department");
  String manager=(String)session.getAttribute("manager");
  String occupation=(String)session.getAttribute("occupation");
  String office_status=(String)session.getAttribute("office_status");
  String date_left=(String)session.getAttribute("date_left");
  String levels_admin=(String)session.getAttribute("levels_admin");
  String levels_boss=(String)session.getAttribute("levels_boss");
  
%>

<%
  if(levels_admin.equals("1") && levels_boss.equals("1")){
      levels = "4";
  }else if(levels_admin.equals("1") && levels_boss.equals("0")){
      levels = "3";
  }else if(levels_admin.equals("0") && levels_boss.equals("1")){
      levels = "2";
  }else{
      levels = "1";
  }
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
    
    String sql="UPDATE STAFF_DATA"+" SET department = '" + department + "'," +" occupation = '" + occupation + "'," +" marital_status = '" + marital_status + "',"+"  manager = '" + manager + "'," +" office_status = '" + office_status + "'," +"  levels = '" + levels + "'" +" WHERE emp_id = '" + emp_id + "'" ;
    
    String sql2="UPDATE STAFF_DATA SET date_left = '"+ date_left +"'"+" WHERE emp_id = '" + emp_id + "'" ;//資料庫語法

    if(date_left.equals("")){
      office_status="1";
      rs=stmt.executeQuery(sql);
    }else{
      office_status="0";
      rs=stmt.executeQuery(sql);
      rs=stmt.executeQuery(sql2);
    }
    
    rs.close(); 
    stmt.close(); 
    conn.close();
  }

  catch(Exception e)
  {
    out.println(e);
  }
%> 
<script>
  alert("員工資料修改成功!"); 
  window.location='Manage.jsp';
</script>