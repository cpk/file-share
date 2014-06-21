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
	String link = "index.jsp?cpk=list_shares.jsp&";
	
	String keySort = request.getParameter("keySort");
	
	if(keySort == null){
		keySort = "name";	
	}
	
	int typeSort = 0;
	
	if(request.getParameter("typeSort") != null){
		typeSort = Integer.parseInt(String.valueOf(request.getParameter("typeSort")));;	
	}

	int goPage = 0;
	int record = 10;
	
	if(request.getParameter("page") != null){
		goPage = Integer.parseInt(String.valueOf(request.getParameter("page")));	
	}

	String logNameFolder = "nameShare";

    	
	DatastoreService datastoreTemp = DatastoreServiceFactory.getDatastoreService();
	Key logKeyFolder = KeyFactory.createKey("keyShare", logNameFolder);
	Query queryFolder;
	if(typeSort==0){
		queryFolder = new Query("share", logKeyFolder).addSort(keySort, Query.SortDirection.ASCENDING);
	}else{
		queryFolder = new Query("share", logKeyFolder).addSort(keySort, Query.SortDirection.DESCENDING);
	}
	List<Entity> foldersFolder = datastoreTemp.prepare(queryFolder).asList(FetchOptions.Builder.withLimit(13091991));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>List shares</title>
<link href="css/layout.css" rel="stylesheet" type="text/css" />

</head>

<body>
<div class="name"><a href="<%= link %>page=<%= goPage %>&keySort=name&typeSort=<%= typeSort %>">Name</a></div>
<div class="name"><a href="<%= link %>page=<%= goPage %>&keySort=root&typeSort=<%= typeSort %>">Root</a></div>
<div class="user"><a href="<%= link %>page=<%= goPage %>&keySort=iduser&typeSort=<%= typeSort %>">User</a></div>
<div class="typelog"><a href="<%= link %>page=<%= goPage %>&keySort=typelog&typeSort=<%= typeSort %>">Type account</a></div>
<div class="keyShare"><a href="<%= link %>page=<%= goPage %>&keySort=keyShare&typeSort=<%= typeSort %>">Key share</a></div>
<div class="level"><a href="<%= link %>page=<%= goPage %>&keySort=type&typeSort=<%= typeSort %>">type</a></div>
<div class="sort"><img src="../img/icon/<% if(typeSort==0){ 
										%><%= "up" %><%
										}else{
										%><%= "down" %><%
										}
										%>.png" width="10" height="7" />&nbsp;&nbsp;<a href="<%= link %>page=<%= goPage %>&keySort=<%= keySort %>&typeSort=<% 
																				if(typeSort==0){ 
																				%><%= 1 %><%
																				}else{
																				%><%= 0 %><%
																				}
																				%>">soft</a></div>
<div class="clear"></div>
<%
	if(!foldersFolder.isEmpty()) {
		int maxPage = (foldersFolder.size()-1)/10;
		int min = goPage*record;
		int max = (goPage+1)*record;
		if(goPage == maxPage){
			max = foldersFolder.size();
		}
		for(int i=min; i<max; i++){
			Entity folder = foldersFolder.get(i);
			Key tempKey = folder.getKey();
			long tempId = tempKey.getId();
			String parentName = tempKey.getParent().getName();
			String parentKind = tempKey.getParent().getKind();
			String tempKind = tempKey.getKind();
			%>
            <form action="index.jsp?form_shares" method="post" name="edit">
            <div class="name" title="<%= folder.getProperty("name") %>"><%= ProcessData.changeString(String.valueOf(folder.getProperty("name"))) %></div>
            <div class="name" title="<%= folder.getProperty("root") %>"><%= ProcessData.changeString(String.valueOf(folder.getProperty("root"))) %></div>
            <div class="user" title="<%= folder.getProperty("iduser") %>"><%= ProcessData.changeString(String.valueOf(folder.getProperty("iduser"))) %></div>
            <% 
				String typeLogTemp = "";
				if(Integer.parseInt(String.valueOf(folder.getProperty("typelog"))) == 1){ 
                	typeLogTemp = "Google account";
				}else{
                	typeLogTemp = "Files Share account";
				}
			%>
            <div class="typelog" title="<%= typeLogTemp %>">
				<%= ProcessData.changeString(typeLogTemp) %>
            </div>
            <div class="keyShare" title="<%= folder.getProperty("keyShare") %>"><%= ProcessData.changeString(String.valueOf(folder.getProperty("keyShare"))) %></div>
            <div class="level" title="<%= folder.getProperty("type") %>"><%= folder.getProperty("type") %></div>
            <input name="iduser" type="hidden" value="<%= folder.getProperty("iduser") %>" />
            <input name="name" type="hidden" value="<%= folder.getProperty("name") %>" />
            <input name="root" type="hidden" value="<%= folder.getProperty("root") %>" />            
            <input name="type" type="hidden" value="<%= folder.getProperty("type") %>" />
            <input name="typelog" type="hidden" value="<%= folder.getProperty("typelog") %>" />
            <div class="edit"><input name="edit" type="submit" value="Edit"/></div>            
            </form>
            <form action="/deleteShare" method="post" name="delete">
            <input name="id" type="hidden" value="<%= tempId %>" />
            <input name="parentName" type="hidden" value="<%= parentName %>" />
            <input name="parentKind" type="hidden" value="<%= parentKind %>" />
            <input name="kind" type="hidden" value="<%= tempKind %>" />
            <div class="delete"><input name="delete" type="submit" value="Delete" /></div>
            </form>
            <div class="clear"></div>
<%
		}
		%>
<div class="page">
        <%	
			if(goPage != 0){
				%>
  <a href="<%= link %>page=0&keySort=<%= keySort %>&typeSort=<%= typeSort %>"><%= "<<" %></a>
  <%	
			}
			min = goPage - 5;
			max = goPage + 5;
			if(min < 0)
				min = 0;
			if(max > maxPage)
				max = maxPage;
			for(int i=min; i<=max; i++){
				if(i==goPage){
					%>
					<b>					
					<%= i+1 %>
					</b>
					<%
				}else{
					%>
					<a href="<%= link %>page=<%= i %>&keySort=<%= keySort %>&typeSort=<%= typeSort %>"><%= i+1 %></a>
                    <%
				}
			}
			if(goPage != maxPage){
				%>
  <a href="<%= link %>page=<%= maxPage %>&keySort=<%= keySort %>&typeSort=<%= typeSort %>"><%= ">>" %></a>
                <%	
			}
		%>
</div>
<%
	}else{
%>
	<div class="page">Empty!</div>
<% } %>
</body>
</html>
<%
}else{
    		response.sendRedirect("/error.jsp?type=account");
    	}
%>