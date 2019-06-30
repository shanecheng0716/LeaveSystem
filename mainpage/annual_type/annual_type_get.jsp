<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%> 
<%

request.setCharacterEncoding( "UTF-8");
String[] data = null;
String emp_id = "";
if(request.getParameter("emp_id")!=null){
    emp_id = request.getParameter("emp_id");
}
else{
	emp_id=(String)session.getAttribute("emp_id");
}
int annual_no =0;
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
       
      String sql="SELECT leave_type,hours FROM ANNUAL_LEAVE_HOURS_SETTING WHERE emp_id = " + "'" + emp_id + "'"; //資料庫語法
      ResultSet rs=stmt.executeQuery(sql);       
      //資料庫欄位顯示，抓不夠會直接抓下一筆，抓太多第一筆就會出錯
        
      ResultSetMetaData rsmd = rs.getMetaData(); 

      //取得欄位數 
      int columnCount = rsmd.getColumnCount(); 

      rs.last(); //把rs指向最後一筆 

      //rs.getRow():取出目前所在的那一筆數 
      data = new String[rs.getRow()*columnCount]; 
      rs.beforeFirst(); //再把rs指回最初的位置 
      
	  for(int i=0;rs.next(); i++) { 
          for(int j=0; j<columnCount; j++) { 
              data[(i*columnCount) +j] = rs.getString(rsmd.getColumnName(j+1)); 
      	  } 
      }

	  rs.close();
      String sql2="SELECT annual_no FROM ANNUAL_LEAVE_HOURS_SETTING";
      ResultSet rs2=stmt.executeQuery(sql2);
	    if(rs2.last()){
	    	annual_no = rs2.getInt("annual_no");
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
    <title>年度假別時數設定</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
  <div class="span_title"><strong>年度假別時數設定</strong></div>

      <table class="table" cellpadding="6" style="width: 300px;" >
        <thead>
            <tr align="center">
              <td class="warning" colspan="2">員工編號：<%=emp_id%></td>
            </tr>
        </thead>
        <tbody>
            <tr align="center">
              <td>假別</td>
              <td>時數</td>
            </tr>
            <tr align="center">
                <% 
     		    for(int i=0; i<data.length; i++) {
                  out.println("<td>"+data[i]+"</td>");
                  if(i%2==1 && i!=data.length) {out.println("</tr><tr align=center>");}
      		    }
      		    %>
            </tr>
            <tr align="center">
              <td class="warning" colspan="2">如要新增或修改假別時數，請輸入：</td>
            </tr>
          <form action="annual_type_add.jsp" method="POST">
            <tr align="center">
              <td>假別名稱</td>
              <td>
		<select name="input_type" required="required" >
			<option value="">請選擇</option>
			<option value="病假">病假</option>
			<option value="事假">事假</option>
			<option value="公假">公假</option>
			<option value="喪假">喪假</option>
			<option value="生產假">生產假</option>
			<option value="生理假">生理假</option>
			<option value="流產假">流產假</option>
			<option value="婚假">婚假</option>
			<option vlaue="陪產假">陪產假</option>		
		</select>
              </td>
            </tr>
            <tr align="center">
              <td>假別時數</td>
              <td><input name="input_hours" pattern="[0-9]+"required   title="請輸入數字" ></td>
            </tr>
            <tr class="warning" align="center">
              <td colspan="2">
                <button type="SUBMIT" class="btn btn-default btn-sm">新增假別時數</button>
                <button type="button" class="btn btn-default btn-sm" onClick="this.form.action='annual_type_alter.jsp';this.form.submit();">修改假別時數</button>
              </td>
            </tr>
          </form>
        </tbody>
      </table>
</center>
</body>
</html>


<%
session.setAttribute("emp_id",emp_id);
session.setAttribute("annual_no",annual_no);

%>
