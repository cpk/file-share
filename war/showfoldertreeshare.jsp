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
<%@ page import="code.getfoldertree" %>
<%@ page import="code.ProcessData" %>
<%
if(session.getAttribute("rootshare") != null && session.getAttribute("idusershare") != null && session.getAttribute("pathshare") != null && session.getAttribute("typelogshare") != null){

		String iduser = (String) session.getAttribute("idusershare");
		String path = (String) session.getAttribute("pathshare");
		String root = (String) session.getAttribute("rootshare");
		String typelog = (String) session.getAttribute("typelogshare");
		ProcessData pd = new ProcessData();
		String[] pathString = pd.getPath(root);
		getfoldertree foldertree = new getfoldertree(iduser, typelog);
		
		String html = "";
		
		%>
        <div class='lili'  onClick='goFolderShare("<%= root %>");'> <img  src='img/icon/foldertree.png' width='20' height='30' style='margin-bottom:-7px;' /><%= pathString[pathString.length - 1] %></div>
        <%
		pathString = pd.getPath(path);
		
		html = foldertree.deQuy(root, 0, pathString);
		
%>
<%= html %>

<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>