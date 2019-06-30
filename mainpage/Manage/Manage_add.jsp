<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
  
int emp_id=0;
String data[] = null;

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
    
    String sql="SELECT emp_id FROM STAFF_DATA";//資料庫語法
    ResultSet rs=stmt.executeQuery(sql);
    if(rs.last()){
    	emp_id=rs.getInt("emp_id");
    }
    emp_id=emp_id+1;
    rs.close();

    String sql2="SELECT emp_name FROM STAFF_DATA where levels= '2' or levels = '4'";
    ResultSet rs2=stmt.executeQuery(sql2);     
    ResultSetMetaData rsmd = rs2.getMetaData(); 

    //取得欄位數 
    int columnCount = rsmd.getColumnCount(); 

    rs2.last(); //把rs指向最後一筆 

    //rs.getRow():取出目前所在的那一筆數 
    data = new String[rs2.getRow()*columnCount]; 
    rs2.beforeFirst(); //再把rs指回最初的位置 
        
        
    for(int i=0;rs2.next(); i++) { 
        for(int j=0; j<columnCount; j++) { 
        //getColumnName(int column) : get the designated column's name 
        data[(i*columnCount) +j] = rs2.getString(rsmd.getColumnName(j+1)); 
        } 
    }
    rs2.close(); 
    stmt.close(); 
    conn.close();
        
}

  catch(Exception e)
  {
    out.println(e);
  }
%> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
  <title>新增員工資料</title>
  <link href="../../css/bootstrap.min.css" rel="stylesheet">
  <link href="../../css/style.css" rel="stylesheet">

 
</head>
<body>
<center>
<div class="span_title"><strong>新增員工資料</strong></div>
    

  <form method="POST" action="Manage_addGet.jsp" >
    <div id="form_content-body">
      <table class="table table-striped" cellpadding="6" style="width: 600px;" >
        <thead>
          <tr>
            <th style="width: 100px;"></th>
            <th style="width: 200px;"></th>
            <th style="width: 100px;">員工編號</th>
            <th style="width: 200px;">
              
              <%=emp_id%>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th>姓名</th>
            <td>
              <input type="TEXT" name="emp_name" required="required">
            </td>
            <th>英文姓名</th>
            <td>
            
              <input type="TEXT" name="english_name" required="required" pattern="[A-Z,a-z]+"  placeholder="請輸入英文" title="請輸入英文(格式AAA-BBB_CCC)">
            </td>
          </tr>

          <tr>
            <th>性別</th>
            <td>
              <select name="sex" required="required">
                <option value="">請選擇</option>
                <option value="0">女</option>
                <option value="1">男</option>
              </select>
            </td>
            <th>出生日期</th>
            <td>
              <input type="date" name="birth" required="required">
            </td>
          </tr>

          <tr>
            <th>婚姻狀態</th>
            <td>
              <select name="marital_status" required="required">
                <option value="">請選擇</option>
                <option value="0">未婚</option>
                <option value="1">已婚</option>
              </select>
            </td>
            <th>電子信箱</th>
            <td>
              <input type="email" name="email" required="required" placeholder="請輸入電子信箱">
            </td>
          </tr>

          <tr>
            <th>部門</th>
            <td>
              <select name="department" required="required">
                <option value="">請選擇</option>
                <option value="資料庫">資料庫</option>
                <option value="網頁">網頁製作</option>
                <option value="美工">美工</option>
              </select>
            </td>
            <th>主管</th>
            <td>
              <select name="manager"  required="required">
                <option value="" selected>請選擇</option>
            <%for(int i=0; i<data.length; i++) {%> 
      			  <option value="<%out.println(data[i]);%>"><%out.println(data[i]);%></option> 
      		<%
      		} %>
              </select>
            </td>
          </tr>

          <tr>
            <th>職稱</th>
            <td>
              <select name="occupation" required="required" >
                <option value="">請選擇</option>
                <option value="員工">員工</option>
                <option value="組長">組長</option>
                <option value="董事長">董事長</option>
              </select>
            </td>
            <th>到職日期</th>
            <td>
              <input type="date" name="date_joined" required="required">
            </td>
          </tr>

          <tr>
            <th>管理者設定</th>
            <td>
              <input type="checkbox" value="1" name ="levels_admin_chk" />
            </td>
            <th>主管設定</th>
            <td>
              <input type="checkbox" value="1" name = "levels_boss_chk" />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div id="form_footer">
      <button class="btn btn-info btn-sm" type="RESET">重寫</button>
      <button class="btn btn-danger btn-sm" type="Submit" >送出</button>
      <button class="btn btn-default btn-sm" type="button" onclick="self.location.href='Manage.jsp'">返回</button>
    </div>
  </form>
  
</center>
</body>
<% 	session.setAttribute("emp_id",emp_id);%>
</html>