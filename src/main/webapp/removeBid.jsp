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

	Hello, Customer Representative:
	
	<%
	try {
		
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String AID = request.getParameter("AID");
			String price = request.getParameter("price");
			
			String select = "SELECT * FROM BidHistory where AID = ? AND currentBid = ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps0 = con.prepareStatement(select);

			ps0.setString(1, AID);
			ps0.setString(2, price);
			
			//Run the query against the DB
			ResultSet result_select = ps0.executeQuery();
			
			String getLoginingUser = "SELECT * FROM UserStack";
			//ResultSet _loginingUser = stmt.executeQuery(getLoginingUser);
			PreparedStatement ps1 = con.prepareStatement(getLoginingUser);
			ResultSet _loginingUser = ps1.executeQuery();
			
			_loginingUser.next();
			
			String loginingUser = _loginingUser.getString(1);
			
			out.println("  " + loginingUser);
			
			%>
			<br>
			<br>
			<%
			
			if (result_select.next()) {
				//remove auction
				
				//try deleting from BidHistory first
				String bidToDelete = "DELETE FROM BidHistory WHERE AID =\"" + AID + "\" AND currentBid =\"" + price + "\"";
				
				stmt.executeUpdate(bidToDelete);
				
				out.println("Bid successfully deleted. Remaining bids after deletion for item with AID " + AID + ":");	
				
				
				//Get the database connection
				ApplicationDB db1 = new ApplicationDB();	
				Connection con1 = db1.getConnection();		
				//Create a SQL statement
				Statement stmt1 = con1.createStatement();
				//Get the selected radio button from the index.jsp
				String entity = request.getParameter("command");
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String bidHistory = "SELECT * FROM BidHistory WHERE AID = " + AID;
				//Run the query against the database.
				ResultSet result = stmt1.executeQuery(bidHistory);
						
						

				%>
						
				<!--  Make an HTML table to show the results in: -->
				<table>
					<tr>
						<br>
						<td>Bid price</td>
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
				
				<%
				
			}

			//result not found, shouldn't occur
			else {
				out.println("There's no matching AID and price in the auction history. Please go back and try again");			
			}

	%>
	
	<%
	} catch (Exception e) {
			out.print(e);
	}%>

	<form method="get" action="CRPage.jsp">
		<input type="submit" value="Return to Customer Representative page" />
	</form>
	<br>

</body>
</html>