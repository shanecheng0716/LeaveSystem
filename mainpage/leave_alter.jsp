<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%> 
<%@ page import=" java.util.*"%> 
<%@ page import=" java.text.*"%> 


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">

<title>Insert title here</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">

<script>//欄位驗證
            function check_select(form){
            	if(leavekinds.value == ""){
                	alert("請選擇假別");
                	return false;
            	}else if(leavedate1.value == ""){
                	alert("請選擇開始日期");
                	return false;
            	}else if(leavedate2.value == ""){
                	alert("請選擇結束日期");
                	return false;
            	}else if(reason.value == ""){
                	alert("請填寫事由");
                	return false;
            	}else{      
                	return true;
            	}
            }
        </script>
</head>
<body>
<%

    String EMP_NAME = "";
    String DETAILS_NO = "";
   	//String EMP_ID = "1001";//還未與登入頁面做連結測試
   	//String FORM_NO = "12347";//還未與登入頁面做連結測試
	String EMP_ID=(String)session.getAttribute("input_user");
   	String FORM_NO=request.getParameter("FORM_NO_alter");
    String DEPARTMENT = "";
    String LEAVES = "";//假別
   	String reason="";
    String[] data = new String[15];//取得代理人員
    String[] data1 = new String[15];//取得可休假別
    
    java.util.Date END_TIME = new java.util.Date();
    java.util.Date START_TIME = new java.util.Date();
    
    SimpleDateFormat sdfmt2 = new SimpleDateFormat("yyyy-MM-dd");

    for(int j=0;j<15;j++){
    	data[j]="";
    	data1[j]="";
    }
	

   	try 
    {  
 
    
        //連接資料庫(需要IP、PORT、DB_SID)
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
        String url="jdbc:oracle:thin:@localhost:1521:xe"; 
        
        String user="test"; 
        String password="test"; 
        Connection conn= DriverManager.getConnection(url,user,password); 
        Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
        
        
       
        String sql1="SELECT * FROM STAFF_DATA WHERE EMP_ID="+EMP_ID;
        ResultSet rs=stmt.executeQuery(sql1); 
        
        if(rs.next())
        {

        	EMP_NAME=rs.getString("EMP_NAME");
        	EMP_ID=rs.getString("EMP_ID");
        	DEPARTMENT=rs.getString("DEPARTMENT");
        }
        
        
        //取得部門代理人員
        String sql2="SELECT EMP_NAME FROM STAFF_DATA WHERE DEPARTMENT="+"'"+DEPARTMENT+"'";     
        ResultSet rs1=stmt.executeQuery(sql2); 
        ResultSetMetaData rsmd = rs1.getMetaData();      
        int columnCount = rsmd.getColumnCount(); //取得欄位數 
        rs1.last(); //把rs指向最後一筆 
        //rs.getRow():取出目前所在的那一筆數 
        data = new String[rs1.getRow()*columnCount]; 
        rs1.beforeFirst(); //再把rs指回最初的位置 
        
        
        		for(int i=0;rs1.next(); i++) {      			
        			data[(i*columnCount)] = rs1.getString(rsmd.getColumnName(1)); 
        		} 

        
      //取得假別
        String sql5="SELECT LEAVE_TYPE FROM ANNUAL_LEAVE_HOURS_SETTING WHERE EMP_ID="+"'"+EMP_ID+"'";     
         rs1=stmt.executeQuery(sql5); 
         rsmd = rs1.getMetaData();      
         columnCount = rsmd.getColumnCount(); //取得欄位數 
        rs1.last(); //把rs指向最後一筆 
        //rs.getRow():取出目前所在的那一筆數 
        data1 = new String[rs1.getRow()*columnCount]; 
        rs1.beforeFirst(); //再把rs指回最初的位置 
        
        
        		for(int i=0;rs1.next(); i++) { 
        			data1[(i*columnCount)] = rs1.getString(rsmd.getColumnName(1)); 
        		} 
        
        
        String sql6="SELECT * FROM DETAILS_OF_PSEUDOMONAS WHERE FORM_NO ="+FORM_NO;
        rs=stmt.executeQuery(sql6); 
                
                if(rs.next())
                {
                	
                	
                	START_TIME=rs.getDate("START_TIME");
                	END_TIME=rs.getDate("END_TIME"); 
                	LEAVES=rs.getString("LEAVES");
                	reason=rs.getString("REASON");
                	
                	
                } 
    
        rs.close();
        rs1.close();
        stmt.close(); 
        conn.close();
        
            
    }

    catch(Exception e)
    {
        //out.println("An exception occurred: " + e.getMessage());
        out.println(e);
    }
   	session.setAttribute("FORM_NO", FORM_NO);
   	session.setAttribute("EMP_NAME", EMP_NAME);
   	session.setAttribute("EMP_ID", EMP_ID);
   	session.setAttribute("DETAILS_NO", DETAILS_NO);
   	session.setAttribute("DEPARTMENT", DEPARTMENT);
  
     %>
     
     <center>
     
     <form method="post" action="leave_alterGet.jsp" onsubmit="return check_select()">
    <br>
    <p><div class="span_title"><strong>填寫假單</strong></div></p>
    <br>
    
    <table class="table table-striped table-hover" cellpadding="6" style="width: 750px;">
        <tr>
            <th><strong>請假單號</strong></th>
            <td width="35%"><%out.print(FORM_NO);%></td>
            <th><strong>填表日期</strong></th>
            <td>
			<%
			
			java.util.Date d1 = new java.util.Date();
		    SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		    Calendar cal = Calendar.getInstance();
		 	
		    //取得目前時間
		    d1 = cal.getTime();
		    out.println(sdfmt.format(d1));
		    
		    
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
           
                  <label for="leavekinds">
                    <select name="leavekinds" id="leavekinds">
                      <%
                	for(int i=0; i<data1.length; i++) { 
        				if(!data1[i].equals("") && data1[i].equals(LEAVES)){
        				%>
        					<option selected value="<%=data1[i]%>"><%=data1[i]%></option>
        				<%
        				}else if(!data1[i].equals("")){
        				%>
        					<option value="<%=data1[i]%>"><%=data1[i]%></option>
        				<%
        				}
        				
        			} 	
                     
        
                %>
                    </select>
                  </label>
               
                
            </td>
        </tr>

        <tr>
            <th><strong>開始時間</strong></th>
            <td colspan="3">
                <label for="startdate">  </label>
                <label for="bookdate">日期：</label>
                <input type="date" name="leavedate1" id="leavedate1" placeholder="2016-05-18" value="<%=sdfmt2.format(START_TIME)%>"> 
                <script>
					var date = document.getElementById('leavedate1');
					function noSundays(e){
  					// Days in JS range from 0-6 where 0 is Sunday and 6 is Saturday
 					 	var day = new Date(e.target.value).getUTCDay();
  						if ( day == 0 || day == 6 ){
    						e.target.setCustomValidity('不可選擇周末！');
  						} else {
    						e.target.setCustomValidity('');
  						}
					}					
					date.addEventListener('input',noSundays);
				</script>
				<style>
					input:invalid {
 					 background-color: #E00;
					}
				</style>
				
                <select name="hour1" id="hour1">
                  <option selected value=08>08</option> 
                  <option value=09>09</option>
                  <option value=10>10</option>
                  <option value=11>11</option>
                  <option value=12>12</option>
                  <option value=13>13</option>
                  <option value=14>14</option>
                  <option value=15>15</option>
                  <option value=16>16</option>
                  
                </select>
                時
                <label for="minute"></label>
                <select name="minute1" id="minute1">
                  <option value=00>00</option>
                  <option selected value=30>30</option>  
                </select>
                分
            </td>
        </tr>


        <tr>
            <th><strong>結束時間</strong></th>
            <td colspan="3">
                <label for="startdate"></label>
                <label for="leavedate2">日期：</label>
                <input type="date" name="leavedate2" id="leavedate2" placeholder="2016-05-18" value="<%=sdfmt2.format(END_TIME)%>">
                <script>
					var date = document.getElementById('leavedate2');
					function noSundays(e){
  					// Days in JS range from 0-6 where 0 is Sunday and 6 is Saturday
 					 	var day = new Date(e.target.value).getUTCDay();
  						if ( day == 0 || day == 6 ){
    						e.target.setCustomValidity('不可選擇周末！');
  						} else {
    						e.target.setCustomValidity('');
  						}
					}					
					date.addEventListener('input',noSundays);
				</script>
				<style>
					input:invalid {
 					 background-color: #E00;
					}
				</style>
                <select name="hour2" id="hour2">
                  
                  <option value=09>09</option>
                  <option value=10>10</option>
                  <option value=11>11</option>
                  <option value=12>12</option>
                  <option value=13>13</option>
                  <option value=14>14</option>
                  <option value=15>15</option>
                  <option value=16>16</option>
                  <option selected value=17>17</option>  
                </select>
                時
                <label for="minute2"></label>
                <select name="minute2" id="minute2">
                  <option value=00>00</option>
                  <option selected value=30>30</option>
                </select>
                分
            </td>
        </tr>

<!--  
        <tr>
            <th><strong>請假時數</strong></th>
            <td colspan="3">
                <input name="hours" type="text" id="hours" size="8" />
                小時</td>
        </tr>
-->
        <tr>
            <th><strong>代理人員工</strong></th>
            <td colspan="3">
                <label for="proxy">
                <select name="agent" id="agent">
                <%
                for(int i=0; i<data.length; i++) { 
        			if(!"".equals(data[i])&&!EMP_NAME.equals(data[i])){
        			%>
        			<option value="<%=data[i]%>"><%=data[i]%></option>
        			<%
        			}
        		} 
        
                %>
                </select>
                </label>
            </td>
        </tr>

        <tr>
            <th>
                <p><strong>請假事由</strong></p>
                <p><strong>(最多1000字）</strong></p>
            </th>
            <td colspan="3">
                <textarea type="text" name="reason" id="reason" cols="50" rows="5" style="resize:none;" ><%=reason %></textarea>
            </td>
        </tr>

    </table>

    <p><input  type="submit"  class="btn btn-default btn-sm" value="提交" /></p>
   
 </form>
</center>
</body>
</html>