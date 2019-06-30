<%@ page contentType="text/html; charset=UTF-8" 
  import="java.sql.*"%>
<% 
request.setCharacterEncoding( "UTF-8");
session.removeAttribute("EMAIL");
session.removeAttribute("FORM_NO");
session.removeAttribute("PSE_STATUS");
session.removeAttribute("VERIFY_REASON");
%> 
<%
int PageSize = 20; //設定每張網頁顯示兩筆記錄
int ShowPage = 1; //設定欲顯示的頁數
int RowCount = 0; //ResultSet的記錄筆數
int PageCount = 0; //ResultSet分頁後的總頁數
ResultSet rs = null;
String STATUS = "";
String FORM_NO = "";
String MAN_NAME_value = (String)session.getAttribute("MAN_NAME");;
String sql_count="";
String data_count="";
 
  try{
    //連接資料庫(需要IP、PORT、DB_SID)
    Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
    String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
    
    //使用者帳號，密碼
    String user="test"; //帳號 
    String password="test"; //密碼 
    Connection conn= DriverManager.getConnection(url,user,password); 
    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS,staff_data WHERE form_head_of_pseudomonas.EMP_ID = staff_data.EMP_ID and staff_data.manager = "+"'"+MAN_NAME_value+"'  ORDER BY FORM_NO DESC";
    String sql="SELECT FORM_NO,APPLY_TIME,APPLICANT,AGENT,PSE_STATUS FROM FORM_HEAD_OF_PSEUDOMONAS,staff_data WHERE form_head_of_pseudomonas.EMP_ID = staff_data.EMP_ID and staff_data.manager = "+"'"+MAN_NAME_value+"'  ORDER BY PSE_STATUS,FORM_NO DESC";

    //建立ResultSet(結果集)物件，並執行SQL敘述
 
    
    rs=stmt.executeQuery(sql_count);
    if(rs.next()){
  	  data_count=rs.getString("COUNT(*)");
    }
   if(data_count.equals("0")){
   }
   else{
    rs=stmt.executeQuery(sql);
   }
    
    
    rs.last(); //將指標移至最後一筆記錄
 
    RowCount = rs.getRow(); //取得ResultSet中記錄的筆數
  
    PageCount = ((RowCount % PageSize) == 0 ? 
        (RowCount/PageSize) : (RowCount/PageSize)+1);
    //計算顯示的頁數
  }
  catch(Exception ex)
  {  
    System.out.println(ex.toString());
  }
//執行資料庫與相關資料的起始

//執行關閉各種物件的動作
%>
<%
     if(data_count.equals("0")){%>
    	 <script>alert("查無資料！"); 
    	  window.history.go(-1); </script>
    	  <%
     }
     else{%>
<%
  String ToPage = request.getParameter("ToPage");
   
  //判斷是否可正確取得ToPage參數, 
  //可取得則表示JSP網頁應顯示特定分頁記錄的敘述
  if(ToPage != null)
  {
    ShowPage = Integer.parseInt(ToPage); //取得指定顯示的分頁頁數
    
    //下面的if敘述將判斷使用者輸入的頁數是否正確
    if(ShowPage > PageCount)
    { //判斷指定頁數是否大於總頁數, 是則設定顯示最後一頁
      ShowPage = PageCount;
    }
    else if(ShowPage <= 0)
    { //若指定頁數小於0, 則設定顯示第一頁的記錄
      ShowPage = 1;
    }
  }
   
  rs.absolute((ShowPage - 1) * PageSize + 1); 
  //計算欲顯示頁的第一筆記錄位置
%>
<html>
<head>
  <title>審核假單狀態</title>
  <link href="../../css/bootstrap.min.css" rel="stylesheet">
  <link href="../../css/style.css" rel="stylesheet">
</head>
<body bgproperties=fixed>
<center>
<div class="span_title"><strong>審核假單狀態</strong></div>
  <H3>
    目前在第<%= ShowPage %>頁, 共有<%= PageCount %>頁
  </H3><br/>
    <table class="table table-striped" cellpadding="4" style="width: 750px;" >
      <thead>
        <tr>
          <th>表單編號</th>
          <th>申請日期</th>
          <th>申請人</th>
          <th>代理人</th>
          <th>處理狀況</th>
          <th>查看或審核</th>
        </tr>
      </thead>
      <tbody>
      <%
      //利用For迴圈配合PageSize屬性輸出一頁中的記錄
      for(int i = 1; i <= PageSize; i++){
        %>
        <tr>
          <td><%=rs.getString("FORM_NO")%></td>
          <td><%=rs.getString("APPLY_TIME")%></td>
          <td><%=rs.getString("APPLICANT")%></td>
          <td><%=rs.getString("AGENT")%></td>
          <td>
            <%
            STATUS = rs.getString("PSE_STATUS");
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
          <form action = "check_getstatus.jsp" mothed="post">
            <td>
              <input type="hidden" name = "FORM_NO" value="<%=rs.getString("FORM_NO")%>"><button class="btn btn-default btn-sm" type="submit">詳細資訊</button>
            </td>
          </form>
        </tr>
        <%
        if(!rs.next()) break;  //判斷是否到達最後一筆記錄，跳出for迴圈
      }//用於防止輸出最後一頁記錄時，將記錄指標移至最後一筆記錄之後
      %>
      </tbody>
    </table>
  
  <div id="pagetopage">
<%
  //判斷目前所在分頁是否為第一頁，不是則顯示到第一頁與上一頁的超連結
  if(ShowPage != 1)
  {
    //下面建立的各超連結將連結至自己，並將欲顯示的分頁以ToPage參數傳遞給自己
    %>
    | 
    <A Href=check_getleave.jsp?ToPage=<%= 1 %>> <span class="glyphicon glyphicon-fast-backward" aria-hidden="true"></span>回第一頁 |</A>
    <A Href=check_getleave.jsp?ToPage=<%= ShowPage - 1 %>> <span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span>回上一頁 |</A>
    <%
  }
   

  if(ShowPage != PageCount) //判斷目前所在分頁是否為最後一頁，不是則顯示到最後一頁與下一頁的超連結
  {
  //下面建立的各超連結將連結至自己，並將欲顯示的分頁以ToPage參數傳遞自己
    %>
    <A Href=check_getleave.jsp?ToPage=<%= ShowPage + 1 %>> <span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>回下一頁 |</A>
    <A Href=check_getleave.jsp?ToPage=<%= PageCount %>> <span class="glyphicon glyphicon-fast-forward" aria-hidden="true"></span>最後一頁 | </A>

    <%
  }
%>
  <form action="check_getleave.jsp" method=POST>
  <!--
  供使用者輸入欲檢視頁數的文字方塊, 預設值為目前所在的分頁, 
  當使用者在此文字方塊中完成資料輸入後按下 Enter 即可將資料送出,
  相當於按下Submit按鈕, 因此此表單中將省略Submit按鈕
  -->
  目前：<%= ShowPage %> / <%= PageCount %> 轉到 <INPUT type="text" name="ToPage" size="1" value="<%= ShowPage%>" > 頁
  </form>

</CENTER>
<%}%>
</BODY>
</HTML>