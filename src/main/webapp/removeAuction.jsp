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

			String AID = request.getParameter("AuctionID");
			
			String select = "SELECT * FROM Auction where AID = ?";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps0 = con.prepareStatement(select);

			ps0.setString(1, AID);
			
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
				String AID_to_Delete = "DELETE FROM BidHistory WHERE AID =\"" + AID + "\"";
				
				stmt.executeUpdate(AID_to_Delete);
				
				//select the bid with the matching AuctionID and delete it
				String auctionToDelete = "DELETE FROM Auction WHERE AID =\"" + AID + "\"";
				
				stmt.executeUpdate(auctionToDelete);
				
				out.println("Auction successfully deleted");	
				
				con.close();
				
			}

			//result not found, shouldn't occur
			else {
				out.println("This auction doesn't exist, please return and enter a valid Auction ID");			
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