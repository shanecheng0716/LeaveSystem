<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
  request.setCharacterEncoding( "UTF-8");
  String emp_id=(String)session.getAttribute("emp_id");
  String emp_name=(String)session.getAttribute("emp_name");
  String english_name=(String)session.getAttribute("english_name");
  String sex=(String)session.getAttribute("sex");
  String birth=(String)session.getAttribute("birth");
  String marital_status=(String)session.getAttribute("marital_status");
  String email=(String)session.getAttribute("email");
  String department=(String)session.getAttribute("department");
  String manager=(String)session.getAttribute("manager");
  String occupation=(String)session.getAttribute("occupation");
  String office_status=(String)session.getAttribute("office_status");
  String date_joined=(String)session.getAttribute("date_joined");
  String date_left=(String)session.getAttribute("date_left");
  String levels_admin=(String)session.getAttribute("levels_admin");
  String levels_boss=(String)session.getAttribute("levels_boss");

  String data[] = null;
  String marital_status_print="";
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
    
    String sql="SELECT emp_name FROM STAFF_DATA where levels= '2' or levels = '4'";;//資料庫語法
    ResultSet rs=stmt.executeQuery(sql); 
                   
    ResultSetMetaData rsmd = rs.getMetaData();
    int columnCount = rsmd.getColumnCount();//取得欄位數

    rs.last(); //把rs指向最後一筆 

    //rs.getRow():取出目前所在的那一筆數 
    data = new String[rs.getRow()*columnCount]; 
    rs.beforeFirst(); //再把rs指回最初的位置

    for(int i=0;rs.next(); i++) { 
      for(int j=0; j<columnCount; j++) { 
      //getColumnName(int column) : get the designated column's name 
      data[(i*columnCount) +j] = rs.getString(rsmd.getColumnName(j+1)); 
      } 
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

<html>
<head>
    <title>修改員工資料</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</head>
<body>
<center>
<div class="span_title"><strong>修改員工資料</strong></div>
  <form action="Manage_alterGet.jsp" method="POST">
    <div id="form_content-body">
      <table class="table table-striped" cellpadding="6" style="width: 600px;" >
        <thead>
          <tr>
            <th style="width: 100px;"></th>
            <th style="width: 200px;"></th>
            <th style="width: 100px;">員工編號</th>
            <th style="width: 200px;">
              <% out.println(emp_id); %>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th>姓名</th>
            <td>
              <% out.println(emp_name); %>
            </td>
            <th>英文姓名</th>
            <td>
              <% out.println(english_name); %>
            </td>
          </tr>

          <tr>
            <th>性別</th>
            <td>
              <%
              if(sex.equals("0")){
                out.println("女");
              }else{
                out.println("男");
              }
              %>
            </td>
            <th>出生日期</th>
            <td>
              <% out.println(birth); %>
            </td>
          </tr>

          <tr>
            <th>婚姻狀態</th>
            <td>
            <%
			if(marital_status.equals("0")){
				marital_status_print="未婚";
			}
			else{
				marital_status_print="已婚";
			}
			%>
              <select name="marital_status">
                <option value="<%out.println(marital_status);%>"><%out.println(marital_status_print);%></option>
                <option value="0">未婚</option>
                <option value="1">已婚</option>
              </select>
            </td>
            <th>電子信箱</th>
            <td>
              <% out.println(email); %>
            </td>
          </tr>

          <tr>
            <th>部門</th>
            <td>
              <select name="department">
                <option value="<%out.println(department);%>"><%out.println(department);%></option>
                <option value="資料庫">資料庫</option>
                <option value="網頁">網頁製作</option>
                <option value="美工">美工</option>
              </select>
            </td>
            <th>主管</th>
            <td>
              <select name="manager">
                <option value="<%out.println(manager);%>"><%out.println(manager);%></option>
                <%
                for(int i=0; i<data.length; i++) {
                  %> 
                  <option value="<%out.println(data[i]);%>"><%out.println(data[i]);%></option> 
                  <%
                }
                %>
              </select>
            </td>
          </tr>

          <tr>
            <th>職稱</th>
            <td>
              <select name="occupation">
                <option value="<%out.println(occupation);%>"><%out.println(occupation);%></option>
                <option value="員工">員工</option>
                <option value="組長">組長</option>
                <option value="董事長">董事長</option>
              </select>
            </td>
            <th>在職狀態</th>
            <td>
              <%
              if(office_status.equals("0")){
                  out.println("離職");
              }
              else{
                  out.println("在職");
              }
              %>
            </td>
          </tr>

          <tr>
            <th>到職日期</th>
            <td>
              <% out.println(date_joined); %>
            </td>
            <th>離職日期</th>
            <td>
                <input type="date" name="date_left">
            </td>
          </tr>
          
          <tr>
            <th>管理者設定</th>
            <td>
              <%
  				if(levels_admin.equals("1")){%>
				  <input type="checkbox" value="1" name="levels_admin_chk"  checked="checked"/>
  				  <%
  				}else{%>
				  <input type="checkbox" value="1" name="levels_admin_chk" />
  				  <%
 				 }
			%>
            </td>
            <th>主管設定</th>
            <td>
              <%
  				if(levels_boss.equals("1")){%>
				  <input type="checkbox" value="1" name="levels_boss_chk"  checked="checked"/>
  				  <%
  				}else{%>
				  <input type="checkbox" value="1" name="levels_boss_chk" />
  				  <%
 				 }
			%>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div id="form_footer">
      <button class="btn btn-danger btn-sm" type="SUBMIT">送出</button>
      <button class="btn btn-info btn-sm" type="RESET">重寫</button>
      <button class="btn btn-default btn-sm" type="BUTTON" onclick="self.location.href='Manage.jsp'">返回</button>
    </div>
  </form>
    
</center>
</body>
</html>
