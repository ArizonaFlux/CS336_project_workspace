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

Hello, User:
	<br>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String AID = request.getParameter("AID");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String bidHistory = "SELECT * FROM BidHistory WHERE AID = " + AID;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(bidHistory);
			
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
			<%
			
			String itemName = "SELECT itemType FROM Auction WHERE AID = " + AID;
			PreparedStatement ps1 = con.prepareStatement(itemName);
			ResultSet itemName1 = ps1.executeQuery();
			itemName1.next();
			String itemName2 = itemName1.getString(1);
			out.println("Price History for " + itemName2 + " with Auction ID " + AID);
				
		%>
		
		<table>
			<tr>
				<br>
				<td>Price</td>
				<%
				//parse out the results
				while (result.next()) { %>
					<tr>    
						<td><%= result.getFloat("currentBid")%></td>
					</tr>
				
				<% }
				//close the connection.
//				db.closeConnection(con);
				%>
			</table>
		
		
		<%} catch (Exception e) {
			out.print(e);
		}%>


	<form method="get" action="userPage.jsp">
		<input type="submit" value="Return to auction page" />
	</form>
	<br>

</body>
</html>