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
	String pass = "";
	pass = request.getParameter("pass");
	String repass = "";
	repass = request.getParameter("repass");
	if(request.getParameter("pass") != null && request.getParameter("repass") != null){
	if(pass.compareTo(repass) == 0 ){
		%>
		<span class="greenText">Accepted!<br /></span>
        <%
	}else{
		%>
		<span class="redText">Confirm is not correct!<br /></span>
        <%
	}
	}else{
		response.sendRedirect("/index.jsp");
	}
%>