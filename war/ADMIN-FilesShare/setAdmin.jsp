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
	String email = "nguyentrankhoa13091991@yahoo.com";

	String logNameFolder = "nameUser";

    	
	DatastoreService datastoreTemp = DatastoreServiceFactory.getDatastoreService();
	Key logKeyFolder = KeyFactory.createKey("keyUser", logNameFolder);
	
	Query queryFolder = new Query("user", logKeyFolder).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, email);
	
	List<Entity> foldersFolder = datastoreTemp.prepare(queryFolder).asList(FetchOptions.Builder.withLimit(13091991));
	
	if (!foldersFolder.isEmpty()) {
		for (Entity folder : foldersFolder) {
			Key tempKey = folder.getKey();
			datastoreTemp.delete(tempKey);
			folder.setProperty("level","1");
			datastoreTemp.put(folder);
		}
	}
%>