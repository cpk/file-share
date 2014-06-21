<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="code.ProcessData" %>
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
<%@ page import="java.util.List" %>
<%
	String name = request.getParameter("name");
	if(request.getParameter("name") != null){
	if(!ProcessData.checkString(name)){
%>
a file name can not contain any of the following characcters: \ / : * ' " | < > ?
<%
	}else{
		String iduser = (String) session.getAttribute("iduser");
	
		String path = (String) request.getParameter("path");
		
		String typelog = (String) session.getAttribute("typelog");
		
		String logNameFolder = "nameFolder";

    	
		DatastoreService datastoreTemp = DatastoreServiceFactory.getDatastoreService();
		Key logKeyFolder = KeyFactory.createKey("keyFolder", logNameFolder);
		
		Query queryFolder = new Query("folder", logKeyFolder).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("name", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
		
		List<Entity> foldersFolder = datastoreTemp.prepare(queryFolder).asList(FetchOptions.Builder.withLimit(13091991));
		
		if (foldersFolder.isEmpty()) {
		
%>
	<input name="" type="submit" value="Rename!" class="button"/>
<%
		}else{
			%>
            Folder is exits!
            <%
		}
	}
	}else{
		response.sendRedirect("/index.jsp");
	}
%>