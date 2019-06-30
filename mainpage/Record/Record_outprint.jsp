<%@ page contentType="text/html;" language="java" import="java.io.*" pageEncoding="UTF-8" %>
<%@ page import="org.apache.poi.hssf.usermodel.*,org.apache.poi.hssf.util.HSSFColor" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%> 

<%

String sql=(String)session.getAttribute("sql");

    String []data=null;
int a=1;
int b=0;
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
        
        ResultSet rs=stmt.executeQuery(sql); 
        
        //資料庫欄位顯示，抓不夠會直接抓下一筆，抓太多第一筆就會出錯
        ResultSetMetaData rsmd = rs.getMetaData(); 

      //取得欄位數 
      int columnCount = rsmd.getColumnCount(); 

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

      		// 印出 data 看看 
 


        rs.close(); 
        stmt.close(); 
        conn.close();
            
    }

    catch(Exception e)
    {
        //out.println("An exception occurred: ");
        out.println(e);
    }
    String WebDirPath = request.getRealPath("/");
    
 String ExcelSampleFilePath = WebDirPath + "mainpage/Record/Record_Excel_example.xls";

      FileInputStream  fs  = new FileInputStream(ExcelSampleFilePath);
      HSSFWorkbook     wb  = new HSSFWorkbook(fs);
      fs.close();
      
      //取得第一個sheet
      HSSFSheet     sheet1     = wb.getSheetAt(0);
      HSSFRow       row        = null;                  //列
      HSSFCell      cell       = null;                  //格
     
      //設定第一種 儲存格 的 屬性 cellStyle 宣告樣式
      HSSFCellStyle cellStyle  = wb.createCellStyle();
      cellStyle.setWrapText(true);  //儲存格自動換列  cellStyle
       
      //以下開始塞資料
        
        	 
        		 
      row = sheet1.createRow(a);  //索引都是從0開始算起
      cell = row.createCell((short)0);
      for(int i=0; i<data.length; i++) {
      if((i%11)==0){
    	  a=a+1;
    	  b=0;
    	  row =sheet1.createRow(a);
          cell = row.createCell((short)b);
          cell.setCellValue(data[i]);
      
      sheet1.autoSizeColumn((short)b); //配合文字縮放cell寬度
      }
      
      else{
          cell = row.createCell((short)b);
          cell.setCellValue(data[i]);
          
          sheet1.autoSizeColumn((short)b); //配合文字縮放cell寬度    	  
          b=b+1;
      } 	 

        	 
         }
      //結束塞資料
      
       //儲存 excel 暫存檔
      String ExcelTempFilePath ="mainpage/Record/Record_Excel_temp.xls";
      FileOutputStream fos = new FileOutputStream(WebDirPath + ExcelTempFilePath);
      wb.write(fos);
      fos.close();
       
      //=============取得TEMP檔案========================================================//
      FileInputStream fis = new FileInputStream( WebDirPath + ExcelTempFilePath);

      SimpleDateFormat SDF = new SimpleDateFormat("yyyyMMdd_HHmmss"); //日期格式
      String fileNameDate = SDF.format(new java.util.Date());//把今天的日期格式化字串
      String filename ="Leave_Records_" + fileNameDate + ".xls";

       //準備讓使用者下載檔案
       out.clear();
       //一定要加charset=iso-8859-1，否則文件內容會亂碼
       //參考：http://www.west263.com/info/html/chengxusheji/Javajishu/20080225/33537.html
       response.setContentType("application/octet-stream; charset=iso-8859-1;");
       response.setHeader("content-disposition","attachment; filename="+filename);

       int byteRead;//設定int，等一下要讀檔用的

        //fis.read()會開始一個byte一個byte讀檔，讀到的byte傳給byteRead		
        //若fis.read()傳回-1，表示讀完了

        while(-1 != (byteRead = fis.read()))
          {
            out.write(byteRead);
          }
        fis.close();
   %>