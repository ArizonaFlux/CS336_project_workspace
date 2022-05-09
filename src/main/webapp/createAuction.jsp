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
		
	Hello, User:
	<br>
	
		<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//get max AID in action table
		Statement stmt0 = con.createStatement();
		String selectMaxAID = "SELECT MAX(AID) FROM Auction";
		PreparedStatement ps = con.prepareStatement(selectMaxAID);
		ResultSet rs0 = ps.executeQuery();
		rs0.next();
		int maxAID = rs0.getInt(1);
		
		//Get current logined user
		Statement stmt1 = con.createStatement();
		String selectCurrentUser = "SELECT * FROM UserStack";
		ps = con.prepareStatement(selectCurrentUser);
		ResultSet rs1 = ps.executeQuery();
		rs1.next();
		String currentUser = rs1.getString(1);
		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String getLoginingUser = "SELECT * FROM UserStack";
		//ResultSet _loginingUser = stmt.executeQuery(getLoginingUser);
		PreparedStatement ps2 = con.prepareStatement(getLoginingUser);
		ResultSet _loginingUser = ps2.executeQuery();
		
		_loginingUser.next();
		
		String loginingUser = _loginingUser.getString(1);
		
		out.println(" -- " + loginingUser + " -- ");

		//Get parameters from the HTML form at the userPage.jsp
		String newItem = request.getParameter("item");
		String newMinPriceStr = request.getParameter("minPrice");
		float newMinPrice = Float.parseFloat(newMinPriceStr);

		//Make a select statement for the UserInfo table:
		String insert = "INSERT INTO Auction(AID, auctionerID, closingDate, minPrice, currentBid, itemType) values (?, ?, '2022-05-07 21:00:00', ?, ?, ?)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps0 = con.prepareStatement(insert);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps0.setInt(1, maxAID + 1);
		ps0.setString(2, currentUser);
		ps0.setFloat(3, newMinPrice);
		ps0.setFloat(4, newMinPrice / 2);
		ps0.setString(5, newItem);
		
		ps0.executeUpdate();

	} catch (Exception e) {
			out.print(e);
	}%>

		<br>
		You have successfully create an auction!
		<br>	
		<form method="get" action="userPage.jsp">
			<input type="submit" value="Go back user page" />
		</form>
		<br>

</body>
</html>