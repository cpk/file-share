<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Files Share</title>
<link href="css/layout.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".signin").click(function(e) {
			e.preventDefault();
			$("fieldset#signin_menu").toggle();
			$(".signin").toggleClass("menu-open");
		});
		$("fieldset#signin_menu").mouseup(function() {
			return false
		});
		$(document).mouseup(function(e) {
			if($(e.target).parent("a.signin").length==0) {
				$(".signin").removeClass("menu-open");
				$("fieldset#signin_menu").hide();
			}
		});
	});
</script>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String email = (String) session.getAttribute("iduser");
	if(email != null){
		response.sendRedirect("/user.jsp");
	}
	if(user != null){
		response.sendRedirect("/login.jsp");
	}
%>
</head>

<body>

<div id="index_header">
  <div id="header_content">
    <div id="logo"><img src="img/logo.png" width="300" height="90"></div>
     <div id="container">
    <div id="topnav" class="topnav"><a href="signin.jsp" class="signup"><span>Sign up</span></a><a href="login" class="signin"><span>Sign in</span></a> </div>
    <fieldset id="signin_menu">
    <form method="post" id="signin" action="/login">
    <label for="username">Username or Email</label>
    <input id="username" name="username" value="" title="username" tabindex="4" type="text">
    </p>
    <p>
    <label for="password">Password</label>
    <input id="password" name="password" value="" title="password" tabindex="5" type="password">
    </p>
    <p class="remember">
    <input id="signin_submit" value="Sign in" tabindex="6" type="submit">
    <input id="remember" name="remember_me" value="1" tabindex="7" type="checkbox">
    <label for="remember">Remember me</label>
    </p>
    <a href='<%= userService.createLoginURL("/login.jsp") %>'>Login with Google account</a>
    </p>
    </form>
    </fieldset>
  </div>
</div>
</div>
<div id="index_content">
  <div id="index_banner">
   	<div id="slide_banner"><%@ include file="/slidebanner.html" %></div>
  </div>
  <div id="index_pr">
  Online Access<br>
  <img src="img/pr/pr1.JPG" width="990"><br>
  Collaboration<br>
  <img src="img/pr/pr2.JPG" width="990"><br>
  Sharing<br>
  <img src="img/pr/pr3.JPG" width="990"><br>
  </div>
  <div id="index_about">
    <div id="about_content"><br>
<br>
<br>


    Copyright © 2013 by Cuipapknight<br>

<br>
<br>
<br>
<br>
<br>

    FILES SHARE
	</div>
  </div>
</div>
</body>
</html>
