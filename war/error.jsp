<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="java.util.List" %>
<%@ page import="code.ProcessData" %>
<%
	String typeerror = request.getParameter("type");
	String message = "";
	if(request.getParameter("type") != null){
	if(typeerror.compareTo("account") == 0){
		message = "Account is not ADMIN!<br /><a href='index.jsp'>Index</a>";
	}
	if(typeerror.compareTo("user") == 0){
		message = "Email is not registered!<br /><a href='index.jsp'>Index</a>";
	}
	if(typeerror.compareTo("pass") == 0){
		message = "Password is not correct!<br /><a href='index.jsp'>Index</a>";
	}
	if(typeerror.compareTo("login") == 0){
		message = "Login please!<br /><a href='index.jsp'>Index</a>";
	}
	if(typeerror.compareTo("type") == 0){
		message = "Login with Files Share account please!<br /><a href='index.jsp'>Index</a>";
	}
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<meta http-equiv="refresh" content="3;URL=index.jsp" />
</head>

<body>
<%= message %>
</body>
</html>
<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>