<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.text.*"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Insert title here</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
<script>//欄位驗證
            function check_select1(form){
            	alert("正在發送EMAIL請稍候.....");
            	return true;
            }
        </script>
</head>
<body>


<%
 
	request.setCharacterEncoding( "UTF-8");
   	String FORM_NO=(String)session.getAttribute("FORM_NO");
   	String DETAILS_NO=(String)session.getAttribute("DETAILS_NO");   	
   	String EMP_ID=(String)session.getAttribute("EMP_ID");
 	String EMP_NAME=(String)session.getAttribute("EMP_NAME");
 	String leavekinds = request.getParameter("leavekinds");
 	int hours_test=0;//判斷剩餘假別時數

   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="TEST"; 
        String password="test"; 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
       //判斷剩餘假別時數
        String sql1="SELECT FN_HOURS FROM ANNUAL_LEAVE_HOURS_SETTING WHERE LEAVE_TYPE="+"'"+leavekinds+"'";
        ResultSet rs=stmt.executeQuery(sql1); 
        
        if(rs.next())
        {
        	hours_test=rs.getInt("FN_HOURS");       	
        }
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
     
     <center>
     
     <form method="post" action="leaveAdd_cofirm.jsp" onsubmit="return check_select1()">
    <br>
    <p><div class="span_title"><strong>假單確認</strong></div></p>
    <br>
    
    <table  class="table table-striped table-hover" cellpadding="6" style="width: 750px;">
        <tr>
            <th><strong>請假單號</strong></th>
            <td width="35%"><%out.println(FORM_NO); %></td>
            <th><strong>填表日期</strong></td>
            <td>

			   <%
			
			java.util.Date d1 = new java.util.Date();
		    SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		    Calendar cal = Calendar.getInstance();
		 
		    //取得目前時間
		    d1 = cal.getTime();
		    out.println(sdfmt.format(d1));
		    session.setAttribute("Today", sdfmt.format(d1));
			%>
			
            </td>
        </tr>


        <tr>
            <th><strong>申請人</strong></th>
            <td><%out.print(EMP_NAME); %></td>
            <th><strong>員工編號</strong></th>
            <td><%out.println(EMP_ID); %></td>
        </tr>


        <tr>
            <th><strong>工作時段</strong></th>
            <td colspan="3">上半日8:30-12:30/下半日13:30-17:30/全日　8:30-17:30</td>
        </tr>


        <tr>
            <th><strong>申請假別</strong></th>
            <td colspan="3">
           
                  <%
                 
                  
                  out.print(leavekinds);  
                  %>
               
                
            </td>
        </tr>

        <tr>
            <th><strong>開始時間</strong></th>
            <td colspan="3">
                <label for="startdate">  </label>
                <label for="bookdate">日期：</label>
               <%
               request.setCharacterEncoding( "UTF-8");
               String leavedate1 = request.getParameter("leavedate1"); 
               out.print(leavedate1+" ");
               String hour1 = request.getParameter("hour1");
               int h1 = Integer.parseInt(hour1);
               out.print(hour1+" 時");
               String minute1 = request.getParameter("minute1"); 
               int m1 = Integer.parseInt(minute1);
               out.print(minute1+" 分");
               String date1=leavedate1+" "+hour1+":"+minute1;
               
               //sdfmt = new SimpleDateFormat("yyyy");
               //out.println(sdfmt.format(leavedate1));
               %> 
                
              
            </td>
        </tr>


        <tr>
            <th><strong>結束時間</strong></th>
            <td colspan="3">
                <label for="startdate">  </label>
                <label for="bookdate">日期：</label>
               <%
               String leavedate2 = request.getParameter("leavedate2"); 
               out.print(leavedate2+" ");
               String hour2 = request.getParameter("hour2");
               int h2 = Integer.parseInt(hour2);
               out.print(hour2+" 時");
               String minute2 = request.getParameter("minute2");
               int m2 = Integer.parseInt(minute2);
               out.print(minute2+" 分");
               String date2=leavedate2+" "+hour2+":"+minute2; 		
               %> 
                
              
            </td>
        </tr>


        <tr>
            <th><strong>請假時數</strong></th>
            <td colspan="3">
            <%
            //request.setCharacterEncoding( "UTF-8");
        	//String hours = request.getParameter("hours");
           	//out.print(hours);
           	
            %>
            <p>
            <script language="JavaScript">
           	var dt = new Date('<%=leavedate1%>');
           	var year1 = dt.getFullYear();
           	var month1 = dt.getMonth()+1;
           	var day1 = dt.getDate();
           	var week1 = dt.getDay();
           	var hour1=<%=h1%>;
           	var minute1=<%=m1%>;
           	//document.write(   year1+ '-' +month1 + '-' + day1 + "星期"+week1);
           	
           	var dt = new Date('<%=leavedate2%>');
           	var year2 = dt.getFullYear();
           	var month2 = dt.getMonth()+1;
           	var day2 = dt.getDate();
           	var week2 = dt.getDay();
           	var hour2=<%=h2%>;
           	var minute2=<%=m2%>;
           	//document.write(   year2+ '-' +month2 + '-' + day2 + "星期"+week1);
           	
           	var year=year2-year1;
           	var month=month2-month1;
           	var minute=minute2-minute1;
           	
           	var day=0;
           	var a1=0,monthsize=0;
           	var months = [0,31,28,31,30,31,30,31,31,30,31,30,31];
           	
           	if(year<0){
           		alert('時間格式錯誤');
           		window.history.go(-1);
           	}
           	if(day2-day1==0&&hour1>hour2){
           		alert('時間格式錯誤');
           		window.history.go(-1);
           	}
           	if(hour1==8&&minute1==0){
           		alert('工作時間為早上8:30');
           		window.history.go(-1);
           	}
           	
    		if(minute==30){
    			minute=0.5;
    		}else if(minute==-30){
    			minute=-1;
    		}
    			
           	if(month==0){//如果是當月
           		if(day2<day1){
           			alert('日期格式錯誤');
               		window.history.go(-1);
           		}
           		day=day2-day1+1;//天數+1 減掉頭尾兩天
           	}else if(month==1){//如果跨一個月
           		day=day2+months[month1]-day1+1
           	}else if(month>=2){//如果跨兩個月以上
           		for(i=month1+1;i<=month2-1;i++){//先計算中間月份天數在算頭尾
           			day=day+months[i];
           		}	
           		day=day+day2+months[month1]-day1+1
           	}else{
           			alert('日期格式錯誤');
               		window.history.go(-1);
           		
           	}
           	
           	if(day<=7)
           	{
           			if(week1>week2){//如果跨週
           				day=day-2;
           			}		
           	}else if(day>7){//a. 先扣掉頭尾兩週 b.算出中間有幾週 c.扣掉中間的六日
           			a1=(day-(7-week1+1+week2))/7;//計算中間有幾周
           			//document.write(a1);
           			day=day-2-(a1*2);//扣除第一周六日再扣除周數*2天假日
           			
           	}
           	
           	var h1 = 0;
           	if (hour1<13){//要減去午休1hr
           		h1=17-hour1-1;
           	}else{
           		h1=17-hour1;
           	}
           	
           	var h2 = 0;
           	if (hour2>13){//要減去午休
           		h2=hour2-9;
           	}else{
           		h2=hour2-8;
           	}   
           	
           	var hours=0;//總小時數
           	hours=(day-2)*8+h1+h2+minute;//扣掉頭尾兩天*8+算的頭尾時數+分鐘數
           	
           	document.write("總共:"+hours+"小時");
           	//document.getElementById('hours1').value = hours;
           	if(<%=hours_test%><hours){//判斷假別可休時數，如果不足就跳上一頁
           		alert('可休<%=leavekinds%>時數不足');
           		window.history.go(-1);
           	}
           	
           	
           	</script>  
           	
           	  <input type="hidden" name="hours2" id="hours2" >      	  
           	  <!--總共
           	    <input type="text" name="hours2" id="hours2" size="4" style="text-align: right" required="required" readonly="readonly" >
           	  小時
           	  <input type="button" value="計算時數" onclick="javascript: getElementById('hours2').value = hours;">
           	  -->
           </td>
        </tr>

        <tr>
            <th><strong>代理人員工</strong></th>
            <td colspan="3">
             <%
            	request.setCharacterEncoding( "UTF-8");
        		String agent = request.getParameter("agent");
           		out.print(agent);
            	%>
               
            </td>
        </tr>

        <tr>
            <th>
                <p><strong>請假事由</strong></p>
                <p><strong>(最多1000字）</strong></p>
            </th>
            <td colspan="3">
            <%
            	request.setCharacterEncoding( "UTF-8");
            	String reason = request.getParameter("reason");
               	out.print(reason);
            %>
                
            </td>
        </tr>

    </table>

    <p>
    <button class="btn btn-default btn-sm" type="BUTTON" onclick="javascript:history.back(1)">返回</button>
    <input class="btn btn-default btn-sm"  type="submit"  value="確認" onclick="javascript: getElementById('hours2').value = hours;" />
    </p>

 </form>
</center>
<%

session.setAttribute("leavekinds", leavekinds);
session.setAttribute("date1", date1);
session.setAttribute("date2", date2);
//session.setAttribute("hours", hours);
session.setAttribute("agent", agent);
session.setAttribute("reason", reason);


%>
</body>
</html>