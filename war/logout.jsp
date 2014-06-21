<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%

	session.removeValue("iduser");
	session.removeValue("email");
	session.removeValue("root");
	session.removeValue("path");
	session.removeValue("lvfolder");
	session.removeValue("typelog");	
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
	if(user != null){
		response.sendRedirect(userService.createLogoutURL("/index.jsp")) ;
	}else{
		response.sendRedirect("/index.jsp");	
	}
%>