<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>User's Home Page</title>
	</head>
<body>

	Hello, User:
	<br>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String auction = "SELECT * FROM Auction";
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
	===============Current auctions===============
	<br>
		
			<!--  Make an HTML table to show the results in: -->
			<table>
			<tr>
				<td>AID---</td>
				<td>Auctioner---</td>
				<td>Closing Date---</td>
				<td>Current Bid---</td>
				<td>Item Name---</td>
				<%
				//parse out the results
				while (result.next()) { %>
					<tr>    
						<td><%= result.getInt("AID")%></td>
						<td><%= result.getString("auctionerID")%></td>
						<td><%= result.getDate("closingDate")%></td>
						<td><%= result.getFloat("currentBid")%></td>
						<td><%= result.getString("itemType")%></td>
					</tr>
					
	
				<% }
				//close the connection.
//				db.closeConnection(con);
				%>
			</table>
			
			<br>
			Want to place a bid?
			<br>
			Please input intended auction ID and your bid to join auction:
			<br>
			<form method="get" action="placeBid.jsp">
				<table>
					<tr>    
						<td>Your Intended AID:</td><td><input type="text" name="AuctionID"></td>
					</tr>
					<tr>
						<td>Your bid:</td><td><input type="text" name="NewBid"></td>
					</tr>
				</table>
				<input type="submit" value="Go Bid!">
			</form>
			<br>
			
			<br>
			Want to sell an item? Then let's create an auction for it!
			<br>
			Please input info about your auction to create one:
			<br>
			<form method="get" action="createAuction.jsp">
				<table>
					<tr>    
						<td>Sold item:</td><td><input type="text" name="item"></td>
					</tr>
					<tr>
						<td>Reserved minimum price:</td><td><input type="text" name="minPrice"></td>
					</tr>
					<tr>
						<td>Closing date:</td><td><input type="text" name="closingDate"></td>
					</tr>
				</table>
				<input type="submit" value="Create Auction!">
			</form>
			<br>
			
			<br>
			Want to check your bid history? 
			
			<br>
			Please input the AID value corresponding to the history you want to check:
			<br>
			<br>
			<form method="get" action="checkHistory.jsp">
					<tr>
						<td>AID:</td><td><input type="text" name="AID"></td>
					</tr>
				</table>
				<input type="submit" value="Check History!">
			</form>
			<br>
		
		<%} catch (Exception e) {
			out.print(e);
		}%>
		

		<br>
		Want to see what auctions you're holding (and edit your auctions)?
			<br>
			<form method="get" action="myAuctionsPage.jsp">
				<input type="submit" value="Go to my auctions">
			</form>
		<br>
		
		<br>
		Want to ask a question?
			<br>
			<form method="get" action="processQuestion.jsp">
			<tr>
						<td></td><td><input type="text" name="question"></td>
					</tr>
				<input type="submit" value="Visit Question Page">
			</form>
		<br>
				
				
		Bid history (testing purposes)
		<%		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get the selected radio button from the index.jsp
		String entity = request.getParameter("command");
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String auction = "SELECT * FROM BidHistory";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(auction);
		%>
				
		<br>	
		
		<!--  Make an HTML table to show the results in: -->
			<table>
			<tr>
				<td>AID---</td>
				<td>Current Bid---</td>
				<%
				//parse out the results
				while (result.next()) { %>
					<tr>    
						<td><%= result.getInt("AID")%></td>
						<td><%= result.getString("currentBid")%></td>
					</tr>
	
				<% }
				//close the connection.
//				db.closeConnection(con);
				%>
			</table>
		<br>
		
			
		<form method="get" action="homePage.jsp">
			<input type="submit" value="Log out" />
		</form>
		<br>

</body>
</html>