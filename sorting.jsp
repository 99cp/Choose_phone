<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
    String url="jdbc:postgresql://localhost:5432/dayseop";
    Connection con = DriverManager.getConnection(url,"postgres","1234");	
	String driver="org.postgresql.Driver";
    
    String select = "select count(*) from product";
    Statement stm = con.createStatement();
    int total = 0;
    ResultSet rs = null;

	String r11 = request.getParameter("radio-group-0");
    String r22 = request.getParameter("radio-group-1");
    String r33 = request.getParameter("radio-group-2");
    String r44 = request.getParameter("radio-group-3");
    String r55 = request.getParameter("radio-group-4");

    int r1 = Integer.parseInt(r11);
    int r2 = Integer.parseInt(r22);
    int r3 = Integer.parseInt(r33);
    int r4 = Integer.parseInt(r44);
    int r5 = Integer.parseInt(r55);

	try{
		
        Class.forName(driver);
        
        rs = stm.executeQuery(select);
        if(rs.next())
        {
            total = rs.getInt(1);
        }
        
		String sql = "CREATE TABLE total(Prod_NAME VARCHAR(255), Prod_PRICE INT, Prod_URL VARCHAR(255), Prod_image VARCHAR(255))"; 
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.executeUpdate(); 
        
        String sql1 = "insert into total (prod_name, prod_price, prod_url, Prod_image) SELECT prod_name, prod_price, Prod_URL, Prod_image From product order by prod_camera limit "+String.valueOf(total/5)+" OFFSET "+String.valueOf(total/5*r1-total/5)+"";
        String sql2 = "insert into total (prod_name, prod_price, prod_url, Prod_image) SELECT prod_name, prod_price, prod_url, Prod_image From product order by prod_size limit "+String.valueOf(total/5)+" OFFSET "+String.valueOf(total/5*r2-total/5)+"";
        String sql3 = "insert into total (prod_name, prod_price, prod_url, Prod_image) SELECT prod_name, prod_price, prod_url, Prod_image From product order by prod_storage limit "+String.valueOf(total/5)+" OFFSET "+String.valueOf(total/5*r3-total/5)+"";
        String sql4 = "insert into total (prod_name, prod_price, prod_url, Prod_image) SELECT prod_name, prod_price, prod_url, Prod_image From product order by prod_memory limit "+String.valueOf(total/5)+" OFFSET "+String.valueOf(total/5*r4-total/5)+"";
        String sql5 = "insert into total (prod_name, prod_price, prod_url, Prod_image) SELECT prod_name, prod_price, prod_url, Prod_image From product order by prod_battery limit "+String.valueOf(total-total/5*4)+" OFFSET "+String.valueOf(total/5*4)+"";

        PreparedStatement pstmt1 = con.prepareStatement(sql1);
        PreparedStatement pstmt2 = con.prepareStatement(sql2);
        PreparedStatement pstmt3 = con.prepareStatement(sql3);
        PreparedStatement pstmt4 = con.prepareStatement(sql4);
        PreparedStatement pstmt5 = con.prepareStatement(sql5);

		pstmt1.executeUpdate(); 
        pstmt2.executeUpdate(); 
        pstmt3.executeUpdate(); 
        pstmt4.executeUpdate(); 
        pstmt5.executeUpdate(); 

        rs.close();
        stm.close();
		pstmt.close();
        pstmt1.close();
        pstmt2.close();
        pstmt3.close();
        pstmt4.close();
        pstmt5.close();
        
		con.close();
	}catch(ClassNotFoundException e) {
		out.println(e);
	}catch(SQLException e){
        out.println(e);
	}
	response.sendRedirect("end.jsp");
%>