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

		<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String newUserID = request.getParameter("ID");
		
		//select the account with the matching ID
		String select = "SELECT * FROM UserInfo where ID = ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps0 = con.prepareStatement(select);

		ps0.setString(1, newUserID);
		
		//Run the query against the DB
		ResultSet result_select = ps0.executeQuery();
		
		if (result_select.next()) {
			//if selected user is CR
			if (result_select.getBoolean("isCR")) {
				
				out.println("User \"" + result_select.getString("ID") + "\" has no CR permission now");
				
				//deauthorize that user in UserInfo table
				String update = "UPDATE UserInfo SET isCR = false WHERE ID = \"" + newUserID +"\"";
				PreparedStatement ps = con.prepareStatement(update);
				ps.executeUpdate();
				
			}
			
			//if selected user is not CR
			else {
				out.println("User \"" + result_select.getString("ID") + "\" has CR permission now");
				
				//deauthorize that user in UserInfo table
				String update = "UPDATE UserInfo SET isCR = true WHERE ID = \"" + newUserID +"\"";
				PreparedStatement ps = con.prepareStatement(update);
				ps.executeUpdate();		
			}
		}

		//result not found, shouldn't occur
		else {
			
			out.println("Failed, there is no user named \"" + newUserID + "\" in the account table\n");
			
			%>
			<br>
			Go back to the previous page and retry
			<%
		}
		
		con.close();

	} catch (Exception e) {
		out.print(e);
	}%>

		<br>
		<form method="get" action="authorizeCRPage.jsp">
			<input type="submit" value="Back to previous page" />
		</form>
		<br>

</body>
</html>