<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home Page</title>
	</head>

	<body>
	Welcome to the auction.com
	<br>
	Login to start your auction journey!!
	<br>
	<br>
	
	<%
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();

			String purgeUserStack = "delete from Userstack";
			//Run the query against the database.
			stmt.executeUpdate(purgeUserStack);
	
		%>
	
	Please input your ID and password to login:
	<br>
		<form method="get" action="login.jsp">
			<table>
				<tr>    
					<td>Your ID:</td><td><input type="text" name="loginID"></td>
				</tr>
				<tr>
					<td>Your Password:</td><td><input type="text" name="loginPassword"></td>
				</tr>
			</table>
			<input type="submit" value="Go Login!">
		</form>
	<br>
	
	If you don't have account, please register first:
		<form method="get" action="register.jsp">
			<table>
				<tr>    
					<td>Your ID:</td><td><input type="text" name="registerID"></td>
				</tr>
				<tr>
					<td>Your Password:</td><td><input type="text" name="registerPassword"></td>
				</tr>
			</table>
			<input type="submit" value="Go Register!">
		</form>
	
	<br>
	Press here to show all pairs of ID and password (for testing purpose):
		<form method="get" action="showAll.jsp">			
			<input type="submit" value="submit" />
		</form>
	<br>
	
	</body>
	
</html>