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
<%@ page import="com.google.appengine.api.blobstore.UploadOptions" %>
<%
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	UploadOptions upOption = UploadOptions.Builder.withMaxUploadSizeBytesPerBlob(50*1024*1024);
	String iduser = (String) session.getAttribute("iduser");
	if (iduser != null){
		String lvfolder = (String) session.getAttribute("lvfolder");
		String path = (String) session.getAttribute("path");
		String root = (String) session.getAttribute("root");
		String typelog = (String) session.getAttribute("typelog");
		ProcessData pd = new ProcessData();
		String[] pathString = pd.getPath(root);
		String lvUser = "0";
		if(typelog.compareTo("0") == 0){
			String logNameUser = "nameUser";
			DatastoreService datastoreUser = DatastoreServiceFactory.getDatastoreService();
			Key logKeyUser = KeyFactory.createKey("keyUser", logNameUser);
			Query queryUser = new Query("user", logKeyUser).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, iduser);
			List<Entity> users = datastoreUser.prepare(queryUser).asList(FetchOptions.Builder.withLimit(13091991));
			if(!users.isEmpty()) {
				for (Entity user : users) {
					lvUser = String.valueOf(user.getProperty("level"));
				}
			}
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>User files</title>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="js/filesshare.js" type="text/javascript"></script>
<script>

</script>
</head>

<body>
<div id="option"></div>
<div id="uploadFile-box" class="uploadFile-popup">
  <a href="#" class="close2"><img src="img/icon/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>
  <form class="signin" action="<%= blobstoreService.createUploadUrl("/upload" , upOption) %>" method="post" enctype="multipart/form-data">            
            <input type="file" name="myFile" class="myfileupload" onchange="getDataFile(this.value);" multiple>
            <input type="hidden" name="typelog" value="<%= typelog %>">    
            <div class="process"></div>        
            <div id="hiddenField">
            </div>
           	
        </form>
</div>
<div id="login-box" class="login-popup">
        <a href="#" class="close"><img src="img/icon/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>
          <form class="signin" onsubmit="return submitForm();" id="creatnewfolder">
                <fieldset class="textbox">
                <label class="username">
                <span>Folder name</span>
                <input id="username" name="username" value="" type="text" autocomplete="on" placeholder="Folder name" onkeyup="checkName(this.value);" />                
                </label> 
                <div id="showSubmit">
                
                </div>
                </fieldset>
  </form>
</div>
<div id="user_top">
  <div id="top_left">
    <div id="logo">
    	<img src="img/logo.png" width="300" height="90" />
    </div>    
    <div id="up" onClick="showUploadForm();">
    	<img src="img/icon/uploadfolder.png" width="70" height="60" /><br />
		Upload
    </div>
    <div id="new">
    	<a href="#login-box" class="login-window">
    		<img src="img/icon/newfolder.png" width="70" height="60" /><br />
			New
        </a>
    </div>
  </div>
  <div id="top_right">
    <div id="avatar">
        <img src="img/icon/avatar.png" width="51" height="34" />
      <div id="avatar_show">
        <%
		
		if(lvUser.compareTo("1") == 0){
			%>
      	<a href="javascript:void(0);" onclick="window.location = '/ADMIN-FilesShare/index.jsp';">Adminitrator</a><br />
			<%
		}
	    %>
        <a href="javascript:void(0);" onclick="window.location = '/user.jsp';">My files</a><br />
        <%
		if(typelog.compareTo("0") == 0){
			%>
        <a href="javascript:void(0);" onclick="window.location = '/accountSetting.jsp';">My account</a><br />
        	<%
		}
		%>
        <a href="javascript:void(0);" onclick="window.location = '/logout.jsp';">Sign out</a>
        </div>
    </div>
    <div id="search">
    	<form onsubmit="return submitFormSearch();" name="search"  class="search"  >
        	<input name="search_text" type="text" id="search_text" size="33"/>
          <input name="button_search" id="button_search" type="image" src="img/icon/search.png"/>          
        </form>
    </div>
  </div>
</div>
<div class="clear"></div>
<div id="adress">
  <div id="adress_up">
    <div id="up_icon" onClick="upFolder();"><img src="img/icon/folder-up-icon.png" width="30" height="30" /></div>
  </div>
  <div id="adress_path"><%= path %></div>
</div>
<div id="user_left">
<div class='lili'  onClick='goFolder("<%= root %>");'> <img  src='img/icon/foldertree.png' width='20' height='30' style='margin-bottom:-7px;' /><%= pathString[pathString.length - 1] %></div>
	<%
		

		getfoldertree foldertree = new getfoldertree(iduser, typelog);
		
		String html = "";
		pathString = pd.getPath(path);
		html = foldertree.deQuy(root, 0, pathString);
	
	%>
    <%= html %>
</div>
<div id="user_right">
  <%@ include file="/show.jsp" %> 
</div>
</body>
</html>
<% }else{ 

response.sendRedirect("/index.jsp");
	 } %>