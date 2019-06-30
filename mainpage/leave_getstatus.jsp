<%@ page contentType="text/html; charset=utf-8" 
  import="java.sql.*"%>
<%
    request.setCharacterEncoding( "UTF-8");
  String DETAILS_NO = ""; // 取得 detals_no 的信息
  String FORM_NOs = "";
  String APPLY_TIME ="";
  String START_TIME = "";
  String END_TIME = "";
  String LEAVES = "";
  String HOURS = "";
  String REASON = "";
  String STATUS = "";
    String APPLICANT = "";
    String AGENT = "";
    String FORM_NO_value = request.getParameter("FORM_NO");
    String VERIFY_REASON="";
    String VERIFY_REASON_print="";
    
    
ResultSet rs = null;
  try{
      //連接資料庫(需要IP、PORT、DB_SID)
      Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
      String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
      
      //使用者帳號，密碼
      String user="test"; //帳號 
      String password="test"; //密碼 
      Connection conn= DriverManager.getConnection(url,user,password); 
      Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
      String sql="SELECT FORM_HEAD_OF_PSEUDOMONAS.*,DETAILS_OF_PSEUDOMONAS.* FROM FORM_HEAD_OF_PSEUDOMONAS,DETAILS_OF_PSEUDOMONAS WHERE FORM_HEAD_OF_PSEUDOMONAS.FORM_NO ="+"'"+FORM_NO_value+"'AND DETAILS_OF_PSEUDOMONAS.FORM_NO = "+"'"+FORM_NO_value+"'";
      rs=stmt.executeQuery(sql);   
    //建立ResultSet(結果集)物件，並執行SQL敘述
   if(rs.next()) 
    {
      FORM_NOs = rs.getString("FORM_NO");
      APPLY_TIME = rs.getString("APPLY_TIME");
      APPLICANT = rs.getString("APPLICANT");
      LEAVES = rs.getString("LEAVES");
      START_TIME = rs.getString("START_TIME");
      END_TIME = rs.getString("END_TIME");
      HOURS = rs.getString("HOURS");
      AGENT = rs.getString("AGENT");
      REASON = rs.getString("REASON");    
      STATUS = rs.getString("PSE_STATUS");
      VERIFY_REASON = rs.getString("VERIFY_REASON");
 }    
    //計算顯示的頁數
  }
  catch(Exception ex)
  {  
    System.out.println(ex.toString());
  }
  
  if(VERIFY_REASON!=null){
	  VERIFY_REASON_print = VERIFY_REASON;
  }
  else{
	  VERIFY_REASON_print = "無";
  }
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>假單明細</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body>
  
<center>
<div class="span_title"><strong>假單明細</strong></div>
  <form>
    <table class="table" cellpadding="6" style="width: 750px;" >
      <tr>
        <th>請假單號</th>
        <td><%out.println(FORM_NOs);%></td>

        <th>審核結果</th>
      </tr>

      <tr>
        <th>申請日期</th>
        <td><%out.println(APPLY_TIME);%></td>
        <td>
          <%

          if(STATUS.equals("1")){
              out.print("已審核");
          }else if(STATUS.equals("2")){
              out.print("已核退");
          }else if(STATUS.equals("3")){
              out.print("已刪除");
          }else{
          	out.print("未審核");
          }
          %>
        </td>
      </tr>
      <tr>
        <th>申請人</th>
        <td><%out.println(APPLICANT);%></td> 
        <th rowspan="7">
               <p>核准或核退原因(核准可不必填寫)：</p>
          <%if(VERIFY_REASON!=null){
        	  out.print(VERIFY_REASON);
          }
          else{
        	  out.print("無");
          }
          %> 
            
            
         </th>
      </tr>

      <tr>
        <th>申請假別</th>
        <td><% out.println(LEAVES);%></td>
      </tr>

      <tr>
        <th>起訖時間</th>
        <td><% out.println(START_TIME);%></td>
      </tr>

      <tr>
        <th>結束時間</th>
        <td><% out.println(END_TIME);%></td>
      </tr>

      <tr>
        <th>請假時數</th>
        <td><% out.println(HOURS);%>小時</td>
      </tr>

      <tr>
        <th>代理人</th>
        <td><% out.println(AGENT);%></td>
      </tr>

      <tr>
        <th>請假事由</th>
        <td><% out.println(REASON);%></td>
      </tr>            
    </table>
  </form>
  <button class="btn btn-default btn-sm" type="button" onclick="self.location.href='leave_getleave.jsp'">返回</button>
</center>
</body>
<%
    session.setAttribute("FORM_NO",FORM_NOs);
    session.setAttribute("APPLICANT",APPLICANT);
 %>
</html>