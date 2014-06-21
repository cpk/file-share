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
<%@ page import="java.util.Vector" %>
<%@ page import="code.ProcessData" %>
<%@ page import="code.Md5" %>

<%

	if(request.getParameter("file") != null && request.getParameter("type") != null && session.getAttribute("iduser") != null && request.getParameter("path") != null && session.getAttribute("typelog") != null){
	String name = (String)request.getParameter("file");
	int type = Integer.parseInt((String)request.getParameter("type"));
	
	String iduser = (String) session.getAttribute("iduser");
	
	String path = (String) request.getParameter("path");
	
	String typelog = (String) session.getAttribute("typelog");
	
	String logName = "nameFolder";
	
	String shareString = new String();
	shareString = iduser + "*" + path + "*" + name + "*" + typelog + "*";
	
	Md5 md5 = new Md5(shareString);
	
	String md5Share = md5.getMd5();
	
    	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key logKey = KeyFactory.createKey("keyFolder", logName);
	
	Query query = new Query("folder", logKey).addSort("iduser", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("name", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	List<Entity> folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	
	if (!folders.isEmpty() && type == 0) {
		for (Entity folder : folders) {
			String namefoldertemp  = new String();
			namefoldertemp = String.valueOf(folder.getProperty("name"));
			int share = Integer.parseInt(String.valueOf(folder.getProperty("share")));
			%>
            <div id="option_top">
              <div id="option_left">
              	<div id="option_left_share">
                    <img src="img/icon/<% if(share == 1){ %>no<% } %>share.png" width="60" height="60" onclick="shareFolder('<%= name %>','<%= md5Share %>','<%= path %>');"/> <br />
                    SHARE&nbsp;&nbsp;
                </div>
                <div id="option_left_link">
                    <% if(share == 1){ %><input name="" type="text" value="http://files-share.appspot.com/share.jsp?keyShare=<%= md5Share %>" size="80"/><% } %>
                </div>
              </div>
              <div id="option_right">
              	<div id="option_right_delete">
                    <img src="img/icon/deletefolder.png" width="60" height="60" onclick="deleteFolder('<%= name %>','<%= path %>');"/> <br />
                    &nbsp;DELETE
                </div>
                <div id="option_right_rename">
                    <img src="img/icon/rename.png" width="60" height="60" onclick="renameFolder('<%= name %>','<%= path %>');"/> <br />
                    &nbsp;RENAME
                </div>
                 <div id="option_right_form_rename">
                     
                </div>
              </div>
            </div>
            <div id="option_bot"><img src="img/icon/close.png" width="40" height="40" onclick="closeOption();"/></div>
			<%
		}
	}
	if(type == 1){
	logName = "nameFile";
	Key logKey2 = KeyFactory.createKey("keyFile", logName);
	Query query2 = new Query("file", logKey2).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("key", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	List<Entity> files = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(13091991));
	if (!files.isEmpty()) {
		for (Entity file : files) {
			String namefiletemp  = new String();
			namefiletemp = String.valueOf(file.getProperty("name"));
			String key  = new String();
			key = String.valueOf(file.getProperty("key"));
			int share = Integer.parseInt(String.valueOf(file.getProperty("share")));
			shareString = iduser + "*" + path + "*" + key + "*" + typelog + "*";
	
			Md5 md5Temp = new Md5(shareString);
			
			md5Share = md5Temp.getMd5();
			%>
            <div id="option_top">
              <div id="option_left">
              <div id="option_left_share">
                <img src="img/icon/<% if(share == 1){ %>no<% } %>share.png" width="60" height="60" onclick="shareFile('<%= name %>','<%= md5Share %>','<%= path %>');"/> <br />
				SHARE&nbsp;&nbsp;
                </div>
                <div id="option_left_link">
                    <% if(share == 1){ %><input name="" size="80" type="text" value="http://files-share.appspot.com/share.jsp?keyShare=<%= md5Share %>"/><% } %>
                </div>              	
              </div>
              <div id="option_right">
              	<img src="img/icon/deletefolder.png" width="60" height="60" onclick="deleteFile('<%= name %>','<%= path %>');"/> <br />
				&nbsp;DELETE
              </div>
            </div>
			<div id="option_bot"><img src="img/icon/close.png" width="40" height="40" onclick="closeOption();"/></div>
			<%	    			
		}
	}
	}
%>

<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>