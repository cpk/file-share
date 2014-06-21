<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.List" %>
<%@ page import="code.getfoldertree" %>
<%@ page import="code.ProcessData" %>
<%@ page import="code.Search" %>
<%
	String iduser = (String) session.getAttribute("iduser");
	
	String path = (String) session.getAttribute("path");
	
	String key = request.getParameter("search_text");
	
	if(session.getAttribute("iduser") != null && session.getAttribute("path") != null && request.getParameter("search_text") != null){
	
	Search s = new Search(iduser, path, key);
	
	String html = s.deQuy(path);
	
%>

<%= html %>

<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>