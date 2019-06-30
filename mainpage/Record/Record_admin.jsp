<%@ page contentType="text/html; charset=utf-8" import="java.sql.*"%>


  <%
  request.setCharacterEncoding( "UTF-8");
 String start_time = "";
 String end_time = "";
 String start_time_first = request.getParameter("start_time");
 String end_time_first = request.getParameter("end_time");
 String flase_time="";
 String error_message="";
 
 String input_emp_name="";
 String input_emp_id="";
 String input_department="";
 String input_emp_name_first = request.getParameter("input_emp_name");
 String input_emp_id_first = request.getParameter("input_emp_id");
 String input_department_first = request.getParameter("input_emp_department");
 

 if(request.getParameter("start_time")!=null || request.getParameter("end_time")!=null){
	    start_time = request.getParameter("start_time");
	    end_time = request.getParameter("end_time");
	    if(start_time.equals("") || end_time.equals("")){
	    	start_time="";
	    	end_time="";
	    	flase_time="開始日期或結束日期未輸入！";
	    }
	}
 else if(start_time_first==null ||end_time_first==null){
	 start_time="";
	 end_time="";
 }
 
 
if(request.getParameter("input_emp_name")!=null){
		input_emp_name = request.getParameter("input_emp_name");
	    if(input_emp_name.equals("")){
	    	input_emp_name="";
	    }
	}
else if(input_emp_name_first==null){
	 input_emp_name="";
}

 if(request.getParameter("input_emp_id")!=null){
		input_emp_id = request.getParameter("input_emp_id");
	    if(input_emp_id.equals("")){
	    	input_emp_id="";
	    }
	}
else if(input_emp_id_first==null){
		input_emp_id="";
} 

 if(request.getParameter("input_department")!=null){
		 input_department = request.getParameter("input_department");
	    if(input_department.equals("")){
	    	input_department="";
	    }
	}
else if(input_department_first==null){
		input_department="";
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
String emp_id="";
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
      
      
      
      String sql1="SELECT leave_type,hours FROM ANNUAL_LEAVE_HOURS_SETTING WHERE emp_id = "+"'" +input_user+ "'";
      rs2=stmt.executeQuery(sql1);
      
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
      
      String sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS ORDER BY FORM_NO DESC";
      
      if(!input_emp_name.equals("") && !input_emp_id.equals("")&& !start_time.equals("") && !end_time.equals("")){
    	  error_message="員工編號跟員工姓名不可同時存在！";
      }
      else if(input_emp_name.equals("") && input_emp_id.equals("")&& !start_time.equals("") && !end_time.equals("")){
    	  String time_sql="APPLY_TIME between to_date('"+start_time+"','yyyy-mm-dd') and to_date('"+end_time+"','yyyy-mm-dd')";
    	  sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS WHERE "+time_sql;
    	  sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS WHERE "+time_sql+ " ORDER BY FORM_NO DESC";
      }

      else if(!input_emp_name.equals("") && input_emp_id.equals("")&& start_time.equals("") && end_time.equals("")){
    	  String input_emp_name_sql="'"+input_emp_name+"'";
    	  sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS WHERE applicant = "+input_emp_name_sql;
    	  sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS WHERE applicant = "+input_emp_name_sql+ " ORDER BY FORM_NO DESC";
      }
      else if(input_emp_name.equals("") && !input_emp_id.equals("")&& start_time.equals("") && end_time.equals("") ){
    	  String input_emp_id_sql="'"+input_emp_id+"'";
    	  sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS WHERE emp_id = "+input_emp_id_sql;
    	  sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS WHERE emp_id = "+input_emp_id_sql+ " ORDER BY FORM_NO DESC";
      }
      else if(input_emp_name.equals("") && !input_emp_id.equals("")&& !start_time.equals("") && !end_time.equals("")){
    	  String time_sql="APPLY_TIME between to_date('"+start_time+"','yyyy-mm-dd') and to_date('"+end_time+"','yyyy-mm-dd')";
    	  String input_emp_id_sql="'"+input_emp_id+"'";
    	  sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS WHERE (emp_id = "+input_emp_id_sql+") "+" AND ("+time_sql+")";
    	  sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS WHERE (emp_id = "+input_emp_id_sql+") "+" AND ("+time_sql+")"+ " ORDER BY FORM_NO DESC";
      }
      else if(!input_emp_name.equals("") && input_emp_id.equals("")&& !start_time.equals("") && !end_time.equals("")){
    	  String time_sql="APPLY_TIME between to_date('"+start_time+"','yyyy-mm-dd') and to_date('"+end_time+"','yyyy-mm-dd')";
    	  String input_emp_name_sql="'"+input_emp_name+"'";
    	  sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS WHERE (applicant = "+input_emp_name_sql+") "+" AND ("+time_sql+")";
    	  sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS WHERE (applicant = "+input_emp_name_sql+") "+" AND ("+time_sql+")"+ " ORDER BY FORM_NO DESC";
      }
      else if(!input_emp_name.equals("") && !input_emp_id.equals("")&& start_time.equals("") && end_time.equals("")){
    	  error_message="員工編號跟員工姓名不可同時存在！";
      }
     // if(!input_department.equals("")){
    //	  String input_emp_department_sql="'"+input_department+"'";
    //	  sql = sql + " department = " +input_department;
    //  }
      else{
    	  sql_count="SELECT COUNT(*) FROM FORM_HEAD_OF_PSEUDOMONAS";
    	  sql="SELECT * FROM FORM_HEAD_OF_PSEUDOMONAS ORDER BY FORM_NO DESC";
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
        <table class="table" cellpadding="6" style="width: 750;">
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
	
	<form action="Record_admin.jsp" method="POST">
    <table class="table" cellpadding="6" style="width: 750;">
      <tr align="center">
        <td colspan="6">
          <strong>起訖期間：</strong>
          <input type="date" name="start_time" id="bookdate" placeholder="2016-05-18">~
          <input type="date" name="end_time" id="bookdate" placeholder="2016-05-18">
        </td>
      </tr>
      <tr align="center">
        <td>
          <strong>員工姓名：</strong>
          <input type="text" name="input_emp_name" size="10">
        </td>
        <td>
          <strong>員工編號：</strong>
          <input type="text" name="input_emp_id" size="8">
        </td>
      </tr>
    </table>
<br/>
<p>
<button type="submit" class="btn btn-default btn-sm">查詢</button>
<button type="reset" class="btn btn-default btn-sm">清除</button>
</p>
		<%
    if(!input_emp_name.equals("") && !input_emp_id.equals("")){
    	out.print(error_message);
    }
    else if(start_time.equals("") && end_time.equals("") && !input_emp_name.equals("")){
    	out.println("員工姓名： "+input_emp_name);
    }
    else if(start_time.equals("") && end_time.equals("") && !input_emp_id.equals("")){
    	out.println("員工編號： "+input_emp_id);
    }
    else if(!start_time.equals("") && !end_time.equals("") && !input_emp_id.equals("")){
    	out.println("員工編號： "+input_emp_id);
    	out.println("　　起始日期： "+start_time);out.println("　　結束日期： "+end_time);
    }
    else if(!start_time.equals("") && !end_time.equals("") && !input_emp_name.equals("")){
    	out.println("員工姓名： "+input_emp_name);
    	out.println("　　起始日期： "+start_time);out.println("　　結束日期： "+end_time);
    }
    else if(start_time.equals("") && end_time.equals("")){
    }
    else if(start_time.equals("") || end_time.equals("")){
	    	out.println(flase_time);
	    }
    else{
    	out.println("起始日期： "+start_time);out.println("　　結束日期： "+end_time);
    }%>
	</form>
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
	request.setCharacterEncoding( "UTF-8");
	%>
 
  <form action="Record_printGet.jsp" method="POST">
    <button type="submit" class="btn btn-default btn-sm" >報表匯出</button>
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
	String form_checkbox[]=new String[21];
	for(int i = 1; i<=PageSize;i++){
		form_checkbox[i] = "form_checkbox_"+i;
	}
	
	for(int i = 1; i <= PageSize; i++)
	{

	  %>
	    <tr align="center">
	      <td><input type="checkbox" name="<%out.print(form_checkbox[i]);%>" value="<%=rs.getString("FORM_NO")%>"></td>
	      <td><%=rs.getString("FORM_NO")%></td>
	      <td>
		    <%
			emp_id = rs.getString("emp_id");
			out.println(emp_id);
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
    		</form>
    		<form>
     	 	<td><button input type="button" class="btn btn-default btn-sm" onClick="this.form.action='Record_get.jsp';this.form.submit();">詳細資訊</button></td>
     		<input type="hidden" name = "FORM_NO" value="<%=rs.getString("FORM_NO")%>">
     		</form>
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
//判斷目前所在分頁是否為第一頁，不是則顯示到第一頁與上一頁的超連結
if(ShowPage != 1)
{
	//下面建立的各超連結將連結至自己，並將欲顯示的分頁以ToPage參數傳遞給自己
  %>
  <div>| 
  <A Href=Record_admin.jsp?ToPage=<%= 1 %>> <span class="glyphicon glyphicon-fast-backward" aria-hidden="true"></span>第一頁 |</A>
  <A Href=Record_admin.jsp?ToPage=<%= ShowPage - 1 %>> <span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span>上一頁 |</A>
  <%
}
 

if(ShowPage != PageCount) //判斷目前所在分頁是否為最後一頁，不是則顯示到最後一頁與下一頁的超連結
{
//下面建立的各超連結將連結至自己，並將欲顯示的分頁以ToPage參數傳遞自己
  %>
  <A Href=Record_admin.jsp?ToPage=<%= ShowPage + 1 %>> <span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>下一頁 |</A>
  <A Href=Record_admin.jsp?ToPage=<%= PageCount %>> <span class="glyphicon glyphicon-fast-forward" aria-hidden="true"></span>最後一頁 | </A>

  <%
}
%>
	<form action="Record_admin.jsp" method=POST>
	<!--
	供使用者輸入欲檢視頁數的文字方塊, 預設值為目前所在的分頁, 
	當使用者在此文字方塊中完成資料輸入後按下 Enter 即可將資料送出,
	相當於按下Submit按鈕, 因此此表單中將省略Submit按鈕
	-->
	目前：<%= ShowPage %> / <%= PageCount %> 轉到 <INPUT type="text" name="ToPage" size="1" value="<%= ShowPage%>" > 頁
	</form>
  </div>
 <%
     }
 %>
</center>
</body>
</HTML>