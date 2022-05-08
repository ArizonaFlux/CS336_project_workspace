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
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the mainPage.jsp
		String newID = request.getParameter("registerID");
		String newPassword = request.getParameter("registerPassword");

		//Make a select statement for the UserInfo table:
		String insert = "INSERT INTO UserInfo(ID, password, isAdmin, isCR) values (?, ?, false, false)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps0 = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps0.setString(1, newID);
		ps0.setString(2, newPassword);
		
		//Run the query against the DB
		ps0.executeUpdate();

		} catch (Exception e) {
			out.print(e);
		}%>
	
	Register successful!
	<br>
	
	<form method="get" action="homePage.jsp">
			<input type="submit" value="Log out" />
	</form>
		
		
</body>
</html>