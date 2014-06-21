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
	String pass = "";
	pass = request.getParameter("pass");
	if(request.getParameter("pass") != null){
	if(pass.length() > 5){
		%>
		<span class="greenText">Accepted!</span><br />
        <input name="repassword" id="repassword" type="password" tabindex="1" placeholder="Confirm Password" size="50" onkeyup="checkRePass(this.value,'<%= pass %>')"/><br /><div id="checkRePass"></div>
        <%
	}else{
		%>
		<span class="redText">Invalid entry for password. 6 characters minumum!<br  /></span>
        <%
	}
	}else{
		response.sendRedirect("/index.jsp");
	}
%>