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
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	String keyShare = "";
	keyShare = request.getParameter("keyShare");
	
	if(keyShare != null){
		ProcessData pd = new ProcessData();
		String logName = "nameShare";
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key logKey = KeyFactory.createKey("keyShare", logName);
		
		
		Query query = new Query("share", logKey).addFilter("keyShare", Query.FilterOperator.EQUAL, keyShare);
		List<Entity> shares = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
		String lvfolder ="";
		int type = 0;
		String nameTemp ="";
		boolean check = false;
		if (!shares.isEmpty()) {
			for (Entity share : shares) {
			lvfolder = String.valueOf(pd.getLevel(String.valueOf(share.getProperty("path"))));
			session.setAttribute("idusershare",String.valueOf(share.getProperty("iduser")));
			session.setAttribute("lvfoldershare",lvfolder);			
			type = Integer.parseInt(String.valueOf(share.getProperty("type")));
			nameTemp = String.valueOf(share.getProperty("name"));
			String pathTemp = String.valueOf(share.getProperty("root")) + "/" + String.valueOf(share.getProperty("name"));
			session.setAttribute("pathshare",pathTemp);
			session.setAttribute("rootshare",pathTemp);
			session.setAttribute("typelogshare",String.valueOf(share.getProperty("typelog")));
			check = true;
			}
		}
				
		if(check){
	String iduser = (String) session.getAttribute("idusershare");
	lvfolder = (String) session.getAttribute("lvfoldershare");
	String path = (String) session.getAttribute("pathshare");
	String root = (String) session.getAttribute("rootshare");
	String typelogshare = (String) session.getAttribute("typelogshare");
	
	String[] pathString = pd.getPath(root);
	if(type == 0){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>User files</title>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="js/filesshare.js" type="text/javascript"></script>
</head>

<body>
<div id="user_top">
  <div id="top_left">
    <div id="logo">
    	<img src="img/logo.png" width="300" height="90" />
    </div>
     <div id="name">
    	<%= iduser %>
    </div>
  </div>
  <div id="top_right">
    <div id="avatar">
        <img src="img/icon/avatar.png" width="51" height="34" />
      <div id="avatar_show">
        <a href="javascript:void(0);" onclick="window.location = '/user.jsp';">My files</a><br />
        <a href="javascript:void(0);" onclick="window.location = '/logout.jsp';">Sign out</a>
        </div>
    </div>
    <div id="search">
    	<form action="return submitFormSearchShare();" name="search">
        	<input name="search_text" type="text" id="search_text" class="search" size="33"/>
          <input name="button_search" id="button_search" type="image" src="img/icon/search.png"/>          
        </form>
    </div>
  </div>
</div>
<div class="clear"></div>
<div id="adress">
  <div id="adress_up">
    <div id="up_icon" onClick="upFolderShare();"><img src="img/icon/folder-up-icon.png" width="30" height="30" /></div>
  </div>
  <div id="adress_path"><%= path %></div>
</div>
<div id="user_left">
<div class='lili'  onClick='goFolderShare("<%= root %>");'> <img  src='img/icon/foldertree.png' width='20' height='30' style='margin-bottom:-7px;' /><%= pathString[pathString.length - 1] %></div>
	<%
		

		getfoldertree foldertree = new getfoldertree(iduser, typelogshare);
		
		String html = "";
		pathString = pd.getPath(path);
		html = foldertree.deQuyShare(root, 0, pathString);
	
	%>
    <%= html %>
</div>
<div id="user_right">
  <%@ include file="/showshare.jsp" %> 
</div>
</body>
</html>
<% }else{
	DatastoreService datastoreTemp = DatastoreServiceFactory.getDatastoreService();
	String logNameFile = "nameFile";
	Key logKeyFile = KeyFactory.createKey("keyFile", logNameFile);
	Query queryFile = new Query("file", logKeyFile).addSort("name", Query.SortDirection.ASCENDING).addFilter("key", Query.FilterOperator.EQUAL, nameTemp);
	List<Entity> filesFile = datastoreTemp.prepare(queryFile).asList(FetchOptions.Builder.withLimit(13091991));
	if (!filesFile.isEmpty()) {
		for (Entity file : filesFile){
			String key  = new String();
			key = String.valueOf(file.getProperty("key"));
			%>
            <script>
			window.location = "/serve?blob-key=<%= key %>"
			</script>
            <%
		}
	}
}
		}else{
			response.sendRedirect("/index.jsp");
		}
}else{ response.sendRedirect("/index.jsp"); } %>