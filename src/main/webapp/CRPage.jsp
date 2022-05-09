<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>CR Page</title>
	</head>
<body>

	Hello, Customer Representative
	
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
			
			out.println("  " + loginingUser);
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
	Want to remove a user's auction? Enter their AID
	<br>
	<form method="get" action="removeAuction.jsp">
		<table>
			<tr>    
				<td>AID:</td><td><input type="text" name="AuctionID"></td>
			</tr>
		</table>
		<input type="submit" value="Remove this auction">
	</form>

	<br>
	Want to remove a certain bid? Enter the AID and the price of the bid you'd like to remove. (Bid history of auctioned items can be found on the main user page)
	<br>
	<form method="get" action="removeBid.jsp">
		<table>
			<tr>    
				<td>AID:</td><td><input type="text" name="AID"></td>
			</tr>
			<tr>    
				<td>price:</td><td><input type="text" name="price"></td>
			</tr>
		</table>
		<input type="submit" value="Remove this bid">
	</form>

	<br>
	Press here to proceed to user interface
		<form method="get" action="userPage.jsp">			
			<input type="submit" value="login as user" />
		</form>
	<br>
	
	
	<%} catch (Exception e) {
			out.print(e);
		}%>
	
	<form method="get" action="homePage.jsp">
		<input type="submit" value="Log out" />
	</form>
	<br>
	
</body>
</html>