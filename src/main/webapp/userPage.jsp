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

	Hello, User
	<br>
	newID
	<br>
	Current auctions:
	<br>
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
			
		%>
		
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
				db.closeConnection(con);
				%>
			</table>
			
			<br>
			Want to place a bid?
			<br>
			Please input intended auction ID and your bid to join auction:
			<br>
			<form method="get" action="bidPage.jsp">
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
		
		<%} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		<br>
		Want to see what auctions you're holding?
				<br>
				<form method="get" action="myAuctionsPage.jsp">
					<input type="submit" value="Go to my auctions">
				</form>
				<br>
		<br>
			
			
		<form method="get" action="homePage.jsp">
			<input type="submit" value="Log out" />
		</form>
		<br>

</body>
</html>