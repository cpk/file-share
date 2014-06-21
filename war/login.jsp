<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String email = (String) session.getAttribute("email");
	if(email != null || user != null){
		if (email != null){
			session.setAttribute("iduser",email);	
		    session.setAttribute("typelog","0");
		}else{
			session.setAttribute("iduser",user.getNickname());
		    session.setAttribute("typelog","1");
		}		
		session.setAttribute("lvfolder","0");
		session.setAttribute("path","root");
		session.setAttribute("root","root");
		response.sendRedirect("/user.jsp");
	}else{
		response.sendRedirect("/index.jsp");
	}
%>