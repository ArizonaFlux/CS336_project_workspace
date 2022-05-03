<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>


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

		//Make an select statement for the UserInfo table:
		String select = "SELECT * FROM UserInfo where ID = ? and password = ?";
		
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
			%>
			
				<form method="get" action="mainPage.jsp">
					<input type="submit" value="Log out" />
				</form>
				<br>	
			<% 
				out.println("Found your ID and password matched in databases, login successfully!!");
			}
			else
			{
				out.println("login failed!!");%>
			
				<form method="get" action="mainPage.jsp">
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