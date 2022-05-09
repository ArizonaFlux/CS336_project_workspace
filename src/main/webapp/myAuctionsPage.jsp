<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>My Auction Page</title>
		
	</head>
<body>

	Hello, User:
	<br>
	
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Get current logined user
		Statement stmt1 = con.createStatement();
		String selectCurrentUser = "SELECT * FROM UserStack";
		PreparedStatement ps = con.prepareStatement(selectCurrentUser);
		ResultSet rs1 = ps.executeQuery();
		rs1.next();
		String currentUser = rs1.getString(1);
		

		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String auction = "SELECT * FROM Auction WHERE AuctionerID = \"" + currentUser + "\"";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(auction);
		
		String getLoginingUser = "SELECT * FROM UserStack";
		//ResultSet _loginingUser = stmt.executeQuery(getLoginingUser);
		PreparedStatement ps0 = con.prepareStatement(getLoginingUser);
		ResultSet _loginingUser = ps0.executeQuery();
		
		_loginingUser.next();
		
		String loginingUser = _loginingUser.getString(1);
		
		out.println(" -- " + loginingUser + " -- ");

		%>
		<br>
		<br>
		The following is the list of your auctions:
		<br>
		===============Your auctions===============
		<br>
		
			<!--  Make an HTML table to show the results in: -->
			<table>
			<tr>
				<td>AID---</td>
				<td>Auctioner---</td>
				<td>Closing Date---</td>
				<td>Current Bid---</td>
				<td>Item Name---</td>
				<td>Minimum reserved price</td>
				<%
				//parse out the results
				while (result.next()) { %>
					<tr>    
						<td><%= result.getInt("AID")%></td>
						<td><%= result.getString("auctionerID")%></td>
						<td><%= result.getDate("closingDate")%></td>
						<td><%= result.getFloat("currentBid")%></td>
						<td><%= result.getString("itemType")%></td>
						<td><%= result.getFloat("MinPrice")%></td>
					</tr>
				<%}%>
			</table>
			
	<%
	} catch (Exception e) {
			out.print(e);
	}%>
	
	<br>
	<form method="get" action="userPage.jsp">
		<input type="submit" value="Back to auctions" />
	</form>
	<br>



</body>
</html>