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
	String email = "";
	email = request.getParameter("email");
	ProcessData pd = new ProcessData();
	if(request.getParameter("email") != null){
	if(pd.checkEmail(email)){
	
		String logName = "nameUser";
    	
    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key logKey = KeyFactory.createKey("keyUser", logName);
		
	    Query query = new Query("user", logKey).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, email);
	    List<Entity> logs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	    
	    if (!logs.isEmpty()) {
			%>
			<span class="redText">Email is already exists!</span><br />
			
            <%
		}else{
			%>
			<span class="greenText">Accepted!</span><br />
<input name="reemail" id="reemail" type="email" tabindex="1" placeholder="Confirm email" size="50" onkeyup="checkReEmail(this.value,'<%= email %>');"/><br /><div id="checkReEmail"></div>
            <%
		}
	}else{
		%>
		<span class="redText">Invalid entry for email!</span>
        <%
	}
	}else{
		response.sendRedirect("/index.jsp");
	}
%>