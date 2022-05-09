<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Creating auction...</title>
	</head>
<body>

<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String getLoginingUser = "SELECT * FROM UserStack";
		//ResultSet _loginingUser = stmt.executeQuery(getLoginingUser);
		PreparedStatement ps1 = con.prepareStatement(getLoginingUser);
		ResultSet _loginingUser = ps1.executeQuery();
		
		_loginingUser.next();
		
		String loginingUser = _loginingUser.getString(1);
		
		String newID = request.getParameter("UserID)");
		String newQuestion = request.getParameter("question");
		
		String insert = "INSERT INTO QuestionBank(UserID, Question, Answer) values (?, ?, \"Default Answer\")";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps0 = con.prepareStatement(insert);
				
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps0.setString(1, loginingUser);
		ps0.setString(2, newQuestion);
		
		ps0.executeUpdate();
		
		
		

	} catch (Exception e) {
			out.print(e);
	}%>
	
	Question is successfully posted
	
	<br>
	<form method="get" action="userPage.jsp">
			<input type="submit" value="Back to auctions" />
		</form>
		<br>

</body>
</html>