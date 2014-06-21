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
	String iduser = (String) session.getAttribute("iduser");
	boolean check = false;
	String firstname = "";
	String lastname = "";
	
	if (iduser != null){
		String typelog = (String) session.getAttribute("typelog");
		if(typelog.compareTo("0") == 0){
			String logNameUser = "nameUser";
			DatastoreService datastoreUser = DatastoreServiceFactory.getDatastoreService();
			Key logKeyUser = KeyFactory.createKey("keyUser", logNameUser);
			Query queryUser = new Query("user", logKeyUser).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, iduser);
			List<Entity> users = datastoreUser.prepare(queryUser).asList(FetchOptions.Builder.withLimit(13091991));
			if(!users.isEmpty()) {
				for (Entity user : users) {
					check = true;
					firstname = String.valueOf(user.getProperty("firstname"));
					lastname = String.valueOf(user.getProperty("lastname"));
				}
			}
		}
	}
	if(check){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="js/filesshare.js" type="text/javascript"></script>
</head>

<body>
<div id="signin">
  <div id="signin_top"><img src="img/logo.png" width="300" height="90"/>&nbsp;&nbsp;&nbsp;Account setting</div>
  <div id="signin_error">
  <%
  	String error = "";
	error = request.getParameter("error");
	if(error != null){
		if(error.compareTo("email") == 0){
			%>
			Invalid entry for email!
			<%	
		}else{
			if(error.compareTo("reemail") == 0){
				%>
				Confirm email is not correct!
				<%	
			}else{
				if(error.compareTo("pass") == 0){
					%>
					Invalid entry for password. 6 characters minumum!
					<%	
				}else{
					if(error.compareTo("repass") == 0){
						%>
						Confirm password is not correct!
						<%	
					}else{
						if(error.compareTo("exitsemail") == 0){
							%>
							Email is already exists!
							<%	
						}	
					}
				}
			}
		}
	}
  %>
  </div>
<div id="signin_cen">

  <form action="/accountSetting" method="post" name="signin">
  <fieldset>
  <input name="firstname" id="firstname" type="text" tabindex="1" placeholder="First Name" size="19" value="<%= firstname %>"/>&nbsp;&nbsp;
  <input name="lastname" id="lastname" type="text" tabindex="1" placeholder="Last Name" size="20" value="<%= lastname %>"/><br />
  <input name="password" id="password" type="password" tabindex="1" placeholder="Password" size="50" onkeyup="checkPass(this.value);"/><br />
  <div id="checkPass"></div>
  <input id="signup_continue" class="gbtnTertiary" type="submit" value="Save Account & Continue" name="signup_continue" />  
  </fieldset>
  </form>
</div>
</div>
<div id="signin_bot">©2013 Files Share  Build 13091991. </div>
</body>
</html>
<% }else{ response.sendRedirect("/index.jsp"); } %>