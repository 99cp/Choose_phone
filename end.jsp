<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>end page</title>

	<link rel="stylesheet" type="text/css" href="end.css">
</head>
<body>
	
	<%
	Connection conn=null;
	String driver="org.postgresql.Driver";
    String url="jdbc:postgresql://localhost:5432/dayseop";
	ResultSet rs = null;
    Statement stmt = null;

	try{
		Class.forName(driver);

		conn=DriverManager.getConnection(url,"postgres","1234");
        
		stmt = conn.createStatement();
        
        rs = stmt.executeQuery("select prod_name, prod_price, prod_url, Prod_image, count(prod_name) from total group by prod_name, prod_price, prod_url, Prod_image having count(prod_name) >0 order by count desc limit 3 offset 0");
    %>
	<section id="container">
		<div class="alpha">
			<br><br>
        <div class="head">
          Day Seop
          <p id="description"><i></i></p>
        </div>
        <br><br>

			<form action="index.html" id="survey-form">
				<br> <br>
				<div class="image1">
					<%
					while (rs.next()) {
					%>
					<div class="img1" id="img1">
					<p><img src='<%=rs.getString("prod_image")%>'></img></p><br>
					<p>제품명 : <%=rs.getString("prod_name")%></p><br>
					<p>가격 : <%=rs.getString("prod_price")%> 원</p><br>
					<p>상품 : <a href='<%=rs.getString("prod_url")%>'>URL</a></p><br>
					<p>정확도 : <%=rs.getInt("count")*20%>%</p>
					</div>
					<br><br>
					<%
					}
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					try {
					if (rs != null) {
						rs.close();
					}
					if (stmt != null){
						stmt.close();
					} 
					if (conn != null) {
						conn.close();
					}
					} catch (Exception e) {
					e.printStackTrace();
					}
					}
					%>
				</div>
				
				<button id="btn">다시하기</button>
			</form>
		</div>
	</section>

</body>

</html>