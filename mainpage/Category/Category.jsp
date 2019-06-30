<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("utf-8");
String tp=(String)session.getAttribute("tp");
String no=(String)session.getAttribute("no");

    try 
    {  
  //22
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
        
        //使用者帳號，密碼
        String user="test"; //帳號 
        String password="test"; //密碼 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
        String sql="SELECT leave_no,leave_type FROM type_of_leave"; 
        //資料庫語法
        ResultSet rs=stmt.executeQuery(sql); 
        
        ResultSetMetaData rsmd = rs.getMetaData ();
        int columnCount = rsmd.getColumnCount ();
        String[] columnLabels = new String[columnCount];
        int[] columnWidths = new int[columnCount];
        for (int i = 1; i <= columnCount; ++i) {
            columnLabels[i-1] = rsmd.getColumnLabel (i);
            columnWidths[i-1] = Math.max (columnLabels[i-1].length(),
                                          rsmd.getColumnDisplaySize (i));
        }
        //顯示
        %>
    
<html>
<head>
  <title>員工假別管理</title>
  <link href="../../css/bootstrap.min.css" rel="stylesheet">
  <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
  <div class="span_title"><strong>員工假別管理</strong></div>
  
  
        <table class="table" cellpadding="6" style="width: 300px;" >
            <tr align="center">
                <td class="warning" colspan="3">顯示現有的假別種類</td>
            </tr>
            <tr align="center">
                <td>假別代碼</td>
                <td>假別名稱</td>
                <td>動作</td>
            </tr>
        <%while(rs.next()) {%>
            <tr align="center">
                <td> <%=no=rs.getString("leave_no")%></td>
                <td> <%=tp=rs.getString("leave_type")%></td>
              <form action = "Category_fix.jsp" mothed="post">
                <td>
                  <input type="hidden" name="fix_no" value="<%=no%>"/><button type="SUBMIT" class="btn btn-default btn-sm">修改</button>
                </td>
              </form>
            </tr>
        <%}%>
            
          <form action="Category_get.jsp" method="POST">
            <tr align="center">
                <td class="warning" colspan="3">如要新增或修改假別，請輸入：</td>
            </tr>
            <tr>
                <td>假別名稱</td>
                <td colspan="2"><input name="input_type" pattern="[\u4E00-\u9FA5]+"required  title="請輸入中文"/></td>
            </tr>
            <tr>
                <td>假別代碼</td>
                <td colspan="2"><input name="input_no" pattern="[0-9]+"required  title="請輸入數字"/></td>
            </tr>
            <tr align="center">
                <td class="warning" colspan="3">
                  <button type="SUBMIT" class="btn btn-default btn-sm">新增假別</button>
                </td>
            </tr>
          </form>
        </table>
</center>
</body>
</html>
<%
        rs.close(); 
        stmt.close(); 
        conn.close();
            
    }
    catch(Exception e)
    {
        //out.println("An exception occurred: " + e.getMessage());
        out.println(e);
    }

%>
<%
session.setAttribute("no",no);
session.setAttribute("tp",tp);
%>
