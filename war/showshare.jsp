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
<%@ page import="java.util.List" %>
<%@ page import="code.getfoldertree" %>
<%@ page import="code.ProcessData" %>
<%
	if(session.getAttribute("idusershare") != null && session.getAttribute("pathshare") != null && session.getAttribute("typelogshare") != null){
	String idusershow = (String) session.getAttribute("idusershare");
	String pathshow = (String) session.getAttribute("pathshare");
	String typelogshow = (String) session.getAttribute("typelogshare");
	
	
	String logNameFolder = "nameFolder";

    	
	DatastoreService datastoreTemp = DatastoreServiceFactory.getDatastoreService();
	Key logKeyFolder = KeyFactory.createKey("keyFolder", logNameFolder);
	
	Query queryFolder = new Query("folder", logKeyFolder).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, idusershow).addFilter("path", Query.FilterOperator.EQUAL, pathshow).addFilter("typelog", Query.FilterOperator.EQUAL, typelogshow);
	
	List<Entity> foldersFolder = datastoreTemp.prepare(queryFolder).asList(FetchOptions.Builder.withLimit(13091991));
	
	if (!foldersFolder.isEmpty()) {
		for (Entity folder : foldersFolder) {
			String namefoldertemp  = new String();
			namefoldertemp = String.valueOf(folder.getProperty("name"));
			String pathTemp = String.valueOf(folder.getProperty("path"));
			int share = Integer.parseInt(String.valueOf(folder.getProperty("share")));
			%>
			<div class="box">
				<img title="<%= namefoldertemp %>" src="img/icon/foldermain<% if(share == 1){ %>share<% } %>.png" width="45" height="70"  onClick="openFolderShare('<%= namefoldertemp %>', '<%= pathTemp %>');"/> <br />
				<%= ProcessData.changeString(namefoldertemp) %>
			</div>
			<%
		}
	}
	String logNameFile = "nameFile";
	Key logKeyFile = KeyFactory.createKey("keyFile", logNameFile);
	Query queryFile = new Query("file", logKeyFile).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, idusershow).addFilter("path", Query.FilterOperator.EQUAL, pathshow).addFilter("typelog", Query.FilterOperator.EQUAL, typelogshow);
	List<Entity> filesFile = datastoreTemp.prepare(queryFile).asList(FetchOptions.Builder.withLimit(13091991));
	if (!filesFile.isEmpty()) {
		for (Entity file : filesFile) {
			String namefiletemp  = new String();
			namefiletemp = String.valueOf(file.getProperty("name"));
			String key  = new String();
			key = String.valueOf(file.getProperty("key"));
			int share = Integer.parseInt(String.valueOf(file.getProperty("share")));
			%>
			<div class="box">    		
				<img title="<%= namefiletemp %>" src="img/icon/file<% if(share == 1){ %>share<% } %>.png" width="45" height="70" onClick='window.location = "/serve?blob-key=<%= key %>"'  /><br />
				<%= ProcessData.changeString(namefiletemp) %>
</div>
			<%	    			
		}
	}
	
	}else{
		response.sendRedirect("/index.jsp");
	}
	%>