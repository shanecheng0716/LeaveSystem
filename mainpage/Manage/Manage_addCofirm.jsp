<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    request.setCharacterEncoding( "UTF-8");
    String levels="1";
%>
<%
	int emp_id=(Integer)session.getAttribute("emp_id");
    String emp_name=(String)session.getAttribute("emp_name");
    String english_name=(String)session.getAttribute("english_name");
    String sex=(String)session.getAttribute("sex");
    String birth=(String)session.getAttribute("birth");
    String marital_status=(String)session.getAttribute("marital_status");
    String email=(String)session.getAttribute("email");
    String department=(String)session.getAttribute("department");
    String manager=(String)session.getAttribute("manager");
    String occupation=(String)session.getAttribute("occupation");
    String date_joined=(String)session.getAttribute("date_joined");
    String levels_admin=(String)session.getAttribute("levels_admin");
    String levels_boss=(String)session.getAttribute("levels_boss");

    String []birth_topass = birth.split("-");
    String birth_topassword = birth_topass[0]+birth_topass[1]+birth_topass[2];
    
    int annual_no=0;
    String type[]=new String[9];

    type[0]="公假";
    type[1]="事假";
    type[2]="病假";
    type[3]="婚假";
    type[4]="喪假";
    type[5]="陪產假";
    type[6]="流產假";
    type[7]="生理假";
    type[8]="產假";
%>

<%
    if(levels_admin.equals("1") && levels_boss.equals("1")){
        levels = "4";
    }else if(levels_admin.equals("1") && levels_boss.equals("0")){
        levels = "3";
    }else if(levels_admin.equals("0") && levels_boss.equals("1")){
        levels = "2";
    }else{
        levels = "1";
    }
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
        
        String sql1="INSERT INTO STAFF_DATA (office_status,emp_id,emp_name,sex,english_name,department,occupation,birth,marital_status,email,manager,date_joined,levels) VALUES('1','"+ emp_id +"',"+"'"+ emp_name +"',"+"'"+ sex +"',"+"'"+ english_name +"',"+"'"+ department +"',"+"'"+ occupation +"',"+"'"+ birth +"',"+"'"+ marital_status +"',"+"'"+ email +"',"+"'"+ manager +"',"+"'"+ date_joined +"',"+"'"+ levels +"')";
        
        String sql2=" INSERT INTO ACCOUNT_PASSWORD(emp_id,password) VALUES('"+ emp_id +"','"+ birth_topassword +"')";
        				//資料庫語法
        ResultSet rs=stmt.executeQuery(sql1);
        rs=stmt.executeQuery(sql2);
        rs.close();
        
        String sql3="SELECT annual_no FROM ANNUAL_LEAVE_HOURS_SETTING";
        ResultSet rs1=stmt.executeQuery(sql3);
  	    if(rs1.last()){
  	    	annual_no = rs1.getInt("annual_no");
  	    	annual_no = annual_no+1;
  	    }     		
        rs1.close();
        
        ResultSet rs2=null;
        
        if(sex.equals("1") && marital_status.equals("1")){
        	for(int i=0;i<6;i++){
        	    String sql4="INSERT INTO ANNUAL_LEAVE_HOURS_SETTING (emp_id,leave_type,hours,annual_no) VALUES (" + "'" +emp_id+  "','" +type[i]+ "', ' 0','" +annual_no+ "')";
                rs2=stmt.executeQuery(sql4);
                annual_no = annual_no+1;
        	}
        }

        else if(sex.equals("1") && marital_status.equals("0")){
        	for(int i=0;i<5;i++){
        	    String sql4="INSERT INTO ANNUAL_LEAVE_HOURS_SETTING (emp_id,leave_type,hours,annual_no) VALUES (" + "'" +emp_id+  "','" +type[i]+ "', ' 0','" +annual_no+ "')";
        	    rs2=stmt.executeQuery(sql4);
        	    annual_no = annual_no+1;
        	}
        }
        else{
        	for(int i=0;i<9;i++){
        		if(i==5){
        		}
        		else{
        	    String sql4="INSERT INTO ANNUAL_LEAVE_HOURS_SETTING (emp_id,leave_type,hours,annual_no) VALUES (" + "'" +emp_id+  "','" +type[i]+ "', ' 0','" +annual_no+ "')";
        	    rs2=stmt.executeQuery(sql4);
        	    annual_no = annual_no+1;
        		}
        	}
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
<script>
  alert("員工資料新增成功!"); 
  window.location='Manage.jsp';
</script>