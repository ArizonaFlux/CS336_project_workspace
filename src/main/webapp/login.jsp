<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logining...</title>
</head>

<!-- notification: -->
<!-- <script>{alert("helloeojefoi")}</script> -->

<body>
		<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the mainPage.jsp
		String newID = request.getParameter("loginID");
		String newPassword = request.getParameter("loginPassword");

		//Make a select statement for the UserInfo table:
		String select = "SELECT * FROM UserInfo where ID = ? and password = ?";
		String addCurrentUser = "INSERT INTO UserStack(ID) value (\"" + newID + "\")";
		
		stmt.executeUpdate(addCurrentUser);
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps0 = con.prepareStatement(select);
		
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps0.setString(1, newID);
		ps0.setString(2, newPassword);
		
		//Run the query against the DB
		ResultSet result_select = ps0.executeQuery();

		%>
		<table>
		<%
			if (result_select.next()){
				if (result_select.getBoolean(3)){ // check if admin account
					
				%>
					Welcome! Proceed to admin page
					<br>
				<form method="get" action="adminPage.jsp">
					<input type="submit" value="Proceed" />
				</form>
				
				<%
				} else if (result_select.getBoolean(4)){  // ckeck if CR account
					
				%>
					Welcome! Proceed to customer representative page
					<br>
				<form method="get" action="CRPage.jsp">
					<input type="submit" value="Proceed" />
				</form>
					
				<%
				} else { // user account
				%>
					Welcome! Proceed to auction page
					<br>
				<form method="get" action="userPage.jsp">
					<input type="submit" value="Proceed" />
				</form>
					
				<%
				}
				%> <br> <%
			
			}
			else
			{
				%>
				login failed!!
				<br><br>
				Check if you input incorrect ID or password
				<br><br>
				If you don't have an account yet, please register first
				
				<br><br>
			
				<form method="get" action="homePage.jsp">
					<input type="submit" value="Try again" />
				</form>

			
			<%}
			db.closeConnection(con);
			%>
		</table>
		
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>