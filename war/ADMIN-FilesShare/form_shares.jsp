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
	String link = "index.jsp?cpk=list_folders.jsp&";
	
	String iduser = request.getParameter("iduser");
	String root = request.getParameter("root");
	String name = request.getParameter("name");
	int type = Integer.parseInt(String.valueOf(request.getParameter("type")));
	String typelog = request.getParameter("typelog");
	
	String logNameFolder = "nameShare";

    	
	DatastoreService datastoreTemp = DatastoreServiceFactory.getDatastoreService();
	Key logKeyFolder = KeyFactory.createKey("keyShare", logNameFolder);
	Query queryFolder = new Query("share", logKeyFolder).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("root", Query.FilterOperator.EQUAL, root).addFilter("name", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog).addFilter("type", Query.FilterOperator.EQUAL, type);
	List<Entity> foldersFolder = datastoreTemp.prepare(queryFolder).asList(FetchOptions.Builder.withLimit(13091991));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Form shares</title>
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
<form action="/editShare" method="post" name="edit">
	<input name="id" type="hidden" value="<%= tempId %>" />
    <input name="parentName" type="hidden" value="<%= parentName %>" />
    <input name="parentKind" type="hidden" value="<%= parentKind %>" />
    <input name="kind" type="hidden" value="<%= tempKind %>" />
  <div class="label">Name: </div><div class="text"><input name="name" type="text" value="<%= folder.getProperty("name") %>"/></div><div class="clear"></div>
  <div class="label">Root: </div><div class="text"><input name="root" type="text" value="<%= folder.getProperty("root") %>"/></div><div class="clear"></div>
  <div class="label">User: </div><div class="text"><input name="iduser" type="text" value="<%= folder.getProperty("iduser") %>"/></div><div class="clear"></div>
  <div class="label">Type account: </div><div class="text">
  <select name="typelog">
  	<option value="0" <% if(Integer.parseInt(String.valueOf(folder.getProperty("typelog"))) == 0){ %> selected="selected" <% } %>>Files Share account</option>
    <option value="1" <% if(Integer.parseInt(String.valueOf(folder.getProperty("typelog"))) == 1){ %> selected="selected" <% } %>>Google account</option>
  </select>
  </div><div class="clear"></div>
  <div class="label">Key share: </div><div class="text"><input name="keyShare" type="text" value="<%= folder.getProperty("keyShare") %>"/></div><div class="clear"></div>
  <div class="label">Type: </div><div class="text">
   <select name="type">
  	<option value="0" <% if(Integer.parseInt(String.valueOf(folder.getProperty("type"))) == 0){ %> selected="selected" <% } %>>Folder</option>
    <option value="1" <% if(Integer.parseInt(String.valueOf(folder.getProperty("type"))) == 1){ %> selected="selected" <% } %>>File</option>
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