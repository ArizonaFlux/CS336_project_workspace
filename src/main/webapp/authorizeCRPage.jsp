<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Authorize CR Page</title>
	</head>
	
</body>

<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM UserInfo WHERE isAdmin = false";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
		
		Hello administrator, you may change user's CR permission in this page
		<br><br>
			
		<!--  Make an HTML table to show the results in: -->
		The following shows the list of all user:
		<br>
		<br>
		<table>
		<tr>    
			<td>ID========        </td>
			<td>isCR======      </td>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("ID") %></td>
					<td><%= result.getBoolean("isCR")%></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		
		<br>
		Please input a user ID to authorize or deauthorize CR permission:
		<br>
		<form method="get" action="CRAuthorization.jsp">
			<table>
				<tr>    
					<td>User ID:</td><td><input type="text" name="ID"></td>
				</tr>
			</table>
			<input type="submit" value="Enter">
		</form>
		<br>
		
		<br>
		<form method="get" action="adminPage.jsp">
			<input type="submit" value="Go back to admin page" />
		</form>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>

</body>
</html>