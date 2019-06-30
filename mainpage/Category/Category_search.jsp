<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>查詢假別種類</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
    <div class="span_title"><strong>查詢假別種類</strong></div>



        <table class="table" cellpadding="6" style="width: 300px;" >
            <tr align="center">
                <td>假別代碼</td>
                <td>假別名稱</td>
            </tr>
        <%
        while(rs.next()) 
        {
        %>
            <tr align="center">
                <td> <%=tp=rs.getString("leave_no")%></td>
                <td> <%=no=rs.getString("leave_type")%></td>
            </tr>
        <%   
        }
        %>
        </table>

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
  <button class="btn btn-default btn-sm" onclick="self.location.href='Category.jsp'">返回</button>
<%
session.setAttribute("no",no);
session.setAttribute("tp",tp);
%>
</center>
</body>
</html>