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
		String emailCheckMenu = String.valueOf(session.getAttribute("iduser"));
    	boolean checkMenu = false;
    	if(session.getAttribute("typelog") != null){
			int typelogCheckMenu = Integer.parseInt(String.valueOf(session.getAttribute("typelog")));
			if(typelogCheckMenu == 0){
				String logNameCheckMenu = "nameUser";
				
				DatastoreService datastoreCheckMenu = DatastoreServiceFactory.getDatastoreService();
				Key logKeyCheckMenu = KeyFactory.createKey("keyUser", logNameCheckMenu);
				Query queryCheckMenu = new Query("user", logKeyCheckMenu).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, emailCheckMenu);
				List<Entity> logsCheckMenu = datastoreCheckMenu.prepare(queryCheckMenu).asList(FetchOptions.Builder.withLimit(13091991));
			   
				if (!logsCheckMenu.isEmpty()) {
					for (Entity logCheck : logsCheckMenu) {
						int levelCheckMenu = Integer.parseInt(String.valueOf(logCheck.getProperty("level")));
						if(levelCheckMenu == 1){
							checkMenu = true;
						}
					}
				}	
			}else{
				response.sendRedirect("../error.jsp?type=type");
			}
    	}else{
			response.sendRedirect("../error.jsp?type=login");
		}
    	if(checkMenu){
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<link href="p7pmm/p7PMMh02.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="p7pmm/p7PMMscripts.js"></script>
</head>

<body>
<div id="p7PMM_1" class="p7PMMh02">
  <ul class="p7PMM">
    <li><a href="../index.jsp">Home</a></li>
    <li><a href="index.jsp?cpk=list_folders">Folder</a></li>
    <li><a href="index.jsp?cpk=list_files">Files</a></li>
    <li><a href="index.jsp?cpk=list_shares">Share</a></li>
    <li><a href="index.jsp?cpk=list_users">User</a></li>
    <li><a href="../logout.jsp">Log out</a></li>
  </ul>
  <div class="p7pmmclearfloat">&nbsp;</div>
  <!--[if lte IE 6]>
<style>.p7PMMh02 ul ul li {float:left; clear: both; width: 100%;}.p7PMMh02 {text-align: left;}.p7PMMh02 ul ul a {height: 1%;}</style>
<![endif]-->
  <!--[if IE 5.500]>
<style>.p7PMMh02 {position: relative; z-index: 9999999;}</style>
<![endif]-->
  <!--[if IE 7]>
<style>.p7PMMh02 {zoom:1;}.p7PMMh02 ul ul li{float:left;clear:both;width:100%;}</style>
<![endif]-->
  <script type="text/javascript">
<!--
P7_PMMop('p7PMM_1',1,4,-5,-5,0,0,0,1,3,3,1,1,0);
//-->
</script>
</div>
</body>
</html>
<%
}else{
    		response.sendRedirect("../error.jsp?type=account");
    	}
		
%>