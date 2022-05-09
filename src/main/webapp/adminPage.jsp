<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin Page</title>
	</head>
<body>

	Hello, administrator
	
	<br>
	<br>
	
	Press here to alter user's Customer Representative permission
		<form method="get" action="authorizeCRPage.jsp">
			
			<input type="submit" value="Go change CR permission" />
		
		</form>
	
	<br>


	Press here to check out the Best Buyers from this auction.
		<form method="get" action="bestBuyers.jsp">
			
			<input type="submit" value="Go check out" />
		
		</form>
	
	<br>
	Press here to proceed to user interface
		<form method="get" action="userPage.jsp">			
			<input type="submit" value="login as user" />
		</form>
	<br>
	
	<form method="get" action="homePage.jsp">
		<input type="submit" value="Log out" />
	</form>
	<br>
	
</body>
</html>