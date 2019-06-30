<%@ page contentType="text/html; charset=utf-8" import="java.sql.*"%>
 <%
 String start_time = "";
 String end_time = "";
 String start_time_first = request.getParameter("start_time");
 String end_time_first = request.getParameter("end_time");
 String flase_time="";
 
 if(request.getParameter("start_time")!=null || request.getParameter("end_time")!=null){
	    start_time = request.getParameter("start_time");
	    end_time = request.getParameter("end_time");
	    if(start_time.equals("") || end_time.equals("")){
	    	start_time="";
	    	end_time="";
	    	flase_time="開始日期或結束日期其中一個未選擇！";
	    }
	}
 else if(start_time_first==null ||end_time_first==null){
	 start_time="";
	 end_time="";
 }



%>

<%
int PageSize = 20; //設定每張網頁顯示兩筆記錄
int ShowPage = 1; //設定欲顯示的頁數
int RowCount = 0; //ResultSet的記錄筆數
int PageCount = 0; //ResultSet分頁後的總頁數
ResultSet rs = null;
ResultSet rs2 = null;
String STATUS = "";
String FORM_NO = "";
String []data = null;
String input_user=(String)session.getAttribute("input_user");
String sql_count="";
String data_count="";

 //執行資料庫與相關資料的起始

  try{
    
      //連接資料庫(需要IP、PORT、DB_SID)
      Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
      String url="jdbc:oracle:thin:@localhost:1521:xe";  //IP:PORT:SID
      
      //使用者帳號，密碼
      String user="test"; //帳號 
      String password="test"; //密碼 
      Connection conn= DriverManager.getConnection(url,user,password); 
      Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
      
      String sql2="SELECT leave_type,hours FROM ANNUAL_LEAVE_HOURS_SETTING WHERE emp_id = " +"'" +input_user+ "'";
      rs2=stmt.executeQuery(sql2);
      
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
      
      
      String sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS WHERE emp_id = "+"'"+input_user+"'"+ " ORDER BY FORM_NO DESC";
      sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS WHERE emp_id = "+"'"+input_user+"'";
           
      if(!start_time.equals("") && !end_time.equals("")){
    	  String time_sql="APPLY_TIME between to_date('"+start_time+"','yyyy-mm-dd') and to_date('"+end_time+"','yyyy-mm-dd')";
    	  sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS WHERE (emp_id = "+"'"+input_user+"') "+" AND ("+time_sql+")";
    	  sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS WHERE (emp_id = "+"'"+input_user+"') "+" AND ("+time_sql+")"+ " ORDER BY FORM_NO DESC";
      }

           
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

 
 //執行關閉各種物件的動作

  
  


%>
<HTML>
<HEAD>
    <title>歷史假單</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">
</HEAD>
<body>
<center>
    <div class="span_title"><strong>年度可休時數</strong></div>
    <div>
        <table class="table" cellpadding="6">
          <thead>
            <tr align="center">
              <td>假別</td>
            <% 
     		for(int i=0; i<data.length; i++) { 
     			if((i+1)%2==1){%>
    	  			<td><%out.println(data[i]);%></td>
    	  			<%
     			}
     			else{
     			}
      		}
      		%>
            </tr>
          </thead>
          <tbody>
            <tr align="center">
              <td>時數</td>
            <% 
     		for(int i=0; i<data.length; i++) { 
     			if((i+1)%2==0){%>
    	  			<td><%out.println(data[i]);%></td>
    	  			<%
     			}
     			else{
     			}
      		}
      		%>
            </tr>
          </tbody>
        </table>
    </div>
    <br/>

	<div class="span_title"><strong>查詢歷史假單</strong></div>
	
	<form action="Record.jsp" method="POST">
    <table class="table" cellpadding="6" style="width: 750;">
      <tr align="center">
        <td colspan="6">
          <strong>起訖期間：</strong>
          <input type="date" name="start_time" id="bookdate" placeholder="2016-05-18">~
          <input type="date" name="end_time" id="bookdate" placeholder="2016-05-18">
        </td>
      </tr>
    </table>
<br/>
<p>
<button type="submit" class="btn btn-default btn-sm">查詢</button>
<button type="reset" class="btn btn-default btn-sm">清除</button>
</p>
	<%
    if(start_time.equals("") || end_time.equals("")){
    	out.println(flase_time);
    }
    else{
    	out.println("起始日期： "+start_time);out.println("　　結束日期： "+end_time);
    }%>
	</form>

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
	request.setCharacterEncoding( "UTF-8");
	%>
 
 <form action = "Record.jsp" mothed="post">    
	<table class="table table-striped table-hover" cellpadding="6" style="width: 750px;">
	  <thead>
	    <tr align="center">
    	  <td></td>
    	  <td>表單編號</td>
    	  <td>員工編號</td>
    	  <td>申請人</td>
    	  <td>代理人</td>
    	  <td>假單狀態</td>
    	  <td>申請時間</td>
    	  <td></td>
        </tr>
      </thead>
	  <tbody>
	<%
	//利用For迴圈配合PageSize屬性輸出一頁中的記錄
	for(int i = 1; i <= PageSize; i++)
	{
	  %>
	    <tr align="center">
	      <td></td>
	      <td><%=rs.getString("FORM_NO")%></td>
	      <td>
		    <%
			out.println(input_user);
			%>
		  </td>
	      <td><%=rs.getString("APPLICANT")%></td>
	      <td><%=rs.getString("AGENT")%></td>
	     <%
         STATUS = rs.getString("PSE_STATUS");
          if(STATUS.equals("1")){
        	  %><td>已審核</td><%
          }
          else if(STATUS.equals("2")){
        	  %><td>已核退</td><%
          }
          else{
        	  %><td>未審核</td><%
          }
          %>
	      <td><%=rs.getString("APPLY_TIME")%></td>
    		<td>
     	 	<td><button input type="submit" class="btn btn-default btn-sm" onClick="this.form.action='Search_get.jsp';this.form.submit();">詳細資訊</button></td>
     		<input type="hidden" name = "FORM_NO" value="<%=rs.getString("FORM_NO")%>">
		  </td>
	    </tr>
	  <%
	  //下面的if判斷敘述用於防止輸出最後一頁記錄時，將記錄指標移至最後一筆記錄之後
	  if(!rs.next())   //判斷是否到達最後一筆記錄
	    break;  //跳出for迴圈
	}%>
	  </tbody>
    </table>
  </form>
	<%
     if(data_count.equals("0")){%>
    	 <script>alert("查無資料！"); 
    	  window.history.go(-1); </script>
    	  <%
     }
     else{%>
<%
//判斷目前所在分頁是否為第一頁，不是則顯示到第一頁與上一頁的超連結
if(ShowPage != 1)
{
	//下面建立的各超連結將連結至自己，並將欲顯示的分頁以ToPage參數傳遞給自己
  %>
  <div>| 
  <A Href=Record.jsp?ToPage=<%= 1 %>> <span class="glyphicon glyphicon-fast-backward" aria-hidden="true"></span>回第一頁 |</A>
  <A Href=Record.jsp?ToPage=<%= ShowPage - 1 %>> <span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span>回上一頁 |</A>
  <%
}
 

if(ShowPage != PageCount) //判斷目前所在分頁是否為最後一頁，不是則顯示到最後一頁與下一頁的超連結
{
//下面建立的各超連結將連結至自己，並將欲顯示的分頁以ToPage參數傳遞自己
  %>
  <A Href=Record.jsp?ToPage=<%= ShowPage + 1 %>> <span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>回下一頁 |</A>
  <A Href=Record.jsp?ToPage=<%= PageCount %>> <span class="glyphicon glyphicon-fast-forward" aria-hidden="true"></span>最後一頁 | </A>

  <%
}
%>
	<form action="Record.jsp" method=POST>
	<!--
	供使用者輸入欲檢視頁數的文字方塊, 預設值為目前所在的分頁, 
	當使用者在此文字方塊中完成資料輸入後按下 Enter 即可將資料送出,
	相當於按下Submit按鈕, 因此此表單中將省略Submit按鈕
	-->
	目前：<%= ShowPage %> / <%= PageCount %> 轉到 <INPUT type="text" name="ToPage" size="1" value="<%= ShowPage%>" > 頁
	</form>
  </div>
 
</center>
<%
     }
%>
</body>
</HTML>