<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp" %>

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

		String newAID = request.getParameter("AuctionID");
		String newBidStr = request.getParameter("NewBid");
		float newBid = Float.parseFloat(newBidStr);
		
		//select the bid with the matching AuctionID
		String select = "SELECT * FROM Auction where AID = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps0 = con.prepareStatement(select);

		ps0.setString(1, newAID);
		
		//Run the query against the DB
		ResultSet result_select = ps0.executeQuery();
		
		if (result_select.next()) {
			//if new bid is higher than old highest bid
			if (newBid > result_select.getFloat("currentBid")) {
				
				out.println("Congratulations! You're now the highest bidder");
				
				//update bid price in Auction table
				String update = "UPDATE Auction SET currentBid = " + newBid + " WHERE AID = " + newAID;
				PreparedStatement ps = con.prepareStatement(update);
				ps.executeUpdate();
				
				//
				
				//update bid history in BidHistory
//				LocalDateTime now = LocalDateTime.now();
//				String insert = "INSERT INTO BidHistory(AID, currentBid, bidDate)" + "VALUES (" + newAID + ", " + newBid + ", " + now + ")";
				String insert = "INSERT INTO BidHistory(AID, currentBid)" + "VALUES (?, ?)";

				
				PreparedStatement ps1 = con.prepareStatement(insert);
				
				ps1.setString(1, newAID);
				ps1.setFloat(2, newBid);
				
				ps1.executeUpdate();
				
				con.close();
			}
			
			else {
				out.println("Your bid needs to be higher than the current bid");
			}
		}

		//result not found, shouldn't occur
		else {
			out.println("This auction doesn't exist anymore");			
		}

	} catch (Exception e) {
		out.print(e);
	}%>
	
	
	<form method="get" action="userPage.jsp">
			<input type="submit" value="Back to user page" />
		</form>
		<br>
	

</body>
</html>