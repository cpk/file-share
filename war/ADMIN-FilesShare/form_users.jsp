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
String emailCheck = String.valueOf(session.getAttribute("iduser"));
    	
    	boolean check = false;
		if(session.getAttribute("typelog") != null){
			int typelogCheck = Integer.parseInt(String.valueOf(session.getAttribute("typelog")));
    	if(typelogCheck == 0){
	    	String logNameCheck = "nameUser";
	    	
	    	DatastoreService datastoreCheck = DatastoreServiceFactory.getDatastoreService();
		    Key logKeyCheck = KeyFactory.createKey("keyUser", logNameCheck);
		    Query query = new Query("user", logKeyCheck).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, emailCheck);
		    List<Entity> logsCheck = datastoreCheck.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
		   
		    if (!logsCheck.isEmpty()) {
		    	for (Entity logCheck : logsCheck) {
		    		int levelCheck = Integer.parseInt(String.valueOf(logCheck.getProperty("level")));
		    		if(levelCheck == 1){
		    			check = true;
		    		}
		    	}
		    }
			}else{
				response.sendRedirect("../error.jsp?type=type");
			}
    	}else{
			response.sendRedirect("../error.jsp?type=login");	    	    	
    	}
    	if(check){
	String link = "index.jsp?cpk=list_users.jsp&";
	
	String email = request.getParameter("email");
	
	String logNameFolder = "nameUser";

    	
	DatastoreService datastoreTemp = DatastoreServiceFactory.getDatastoreService();
	Key logKeyFolder = KeyFactory.createKey("keyUser", logNameFolder);
	Query queryFolder = new Query("user", logKeyFolder).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, email);
	List<Entity> foldersFolder = datastoreTemp.prepare(queryFolder).asList(FetchOptions.Builder.withLimit(13091991));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>File users</title>
<link href="css/layout.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div id="form">
<%
if(!foldersFolder.isEmpty()) {
	for (Entity folder : foldersFolder) {	
		Key tempKey = folder.getKey();
		long tempId = tempKey.getId();
		String parentName = tempKey.getParent().getName();
		String parentKind = tempKey.getParent().getKind();
		String tempKind = tempKey.getKind();
%>
<form action="/editUser" method="post" name="edit">
	<input name="id" type="hidden" value="<%= tempId %>" />
    <input name="parentName" type="hidden" value="<%= parentName %>" />
    <input name="parentKind" type="hidden" value="<%= parentKind %>" />
    <input name="kind" type="hidden" value="<%= tempKind %>" />
  <div class="label">First name: </div><div class="text"><input name="firstname" type="text" value="<%= folder.getProperty("firstname") %>"/></div><div class="clear"></div>
  <div class="label">Last name: </div><div class="text"><input name="lastname" type="text" value="<%= folder.getProperty("lastname") %>"/></div><div class="clear"></div>
  <div class="label">Email: </div><div class="text"><input name="email" type="text" value="<%= folder.getProperty("email") %>"/></div><div class="clear"></div>
  <div class="label">Password: </div><div class="text"><input name="password" type="text" value="<%= folder.getProperty("password") %>"/></div><div class="clear"></div>
  <div class="label">Level: </div><div class="text">
  <select name="level">
  	<option value="0" <% if(Integer.parseInt(String.valueOf(folder.getProperty("level"))) == 0){ %> selected="selected" <% } %>>User</option>
    <option value="1" <% if(Integer.parseInt(String.valueOf(folder.getProperty("level"))) == 1){ %> selected="selected" <% } %>>Admin</option>
  </select>
  </div><div class="clear"></div>
  <div class="button"><input name="" type="submit" value="Edit" /></div>
</form>
</div>
</body>
</html>
<%
	}
}
}else{
    		response.sendRedirect("/error.jsp?type=account");
    	}
%>