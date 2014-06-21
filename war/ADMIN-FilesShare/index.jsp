<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String[] pageLoad = {"list_folders","list_files","list_shares","list_users",
					"form_folders","form_files","form_shares","form_users"};
	String cpk = (String)request.getParameter("cpk");
	String emailCheckIndex = String.valueOf(session.getAttribute("iduser"));
    	
    	boolean checkIndex = false;
    	if(session.getAttribute("typelog") != null){
			int typelogCheckIndex = Integer.parseInt(String.valueOf(session.getAttribute("typelog")));
			if(typelogCheckIndex == 0){
	    	String logNameCheckIndex = "nameUser";
	    	
	    	DatastoreService datastoreCheckIndex = DatastoreServiceFactory.getDatastoreService();
		    Key logKeyCheckIndex = KeyFactory.createKey("keyUser", logNameCheckIndex);
		    Query queryCheckIndex = new Query("user", logKeyCheckIndex).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, emailCheckIndex);
		    List<Entity> logsCheckIndex = datastoreCheckIndex.prepare(queryCheckIndex).asList(FetchOptions.Builder.withLimit(13091991));
		   
		    if (!logsCheckIndex.isEmpty()) {
		    	for (Entity logCheck : logsCheckIndex) {
		    		int levelCheckIndex = Integer.parseInt(String.valueOf(logCheck.getProperty("level")));
		    		if(levelCheckIndex == 1){
		    			checkIndex = true;
		    		}
		    	}
		    }	    	
    		
			}else{
				response.sendRedirect("../error.jsp?type=type");
			}
    	}else{
			response.sendRedirect("../error.jsp?type=login");
		}
    	if(checkIndex){
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>ADMIN</title>
<link href="css/layout.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
</head>

<body>
<div id="admin_top">
	<div id="admin_top_logo"><img src="../img/logo.png" width="300" height="90"></div>
    <div id="admin_top_menu"><%@ include file="menu.jsp" %></div>
</div>
<div id="admin_cen">
<%
	if(cpk != null){
		for(int i=0; i<pageLoad.length; i++){
			if(cpk.compareTo(pageLoad[i]) == 0){
				String cpkPage = pageLoad[i] + ".jsp";
				%>
				<jsp:include page="<%= cpkPage %>" />
				<%	
			}
		}
	}else{
%>
	<div class="welcome">WELCOME TO ADMINISTRATOR PAGE!</div>
<%
	}
%>
</div>
<div id="admin_bot">Content for  id "admin_top" Goes Here</div>
</body>
</html>
<%
	
}else{
    		response.sendRedirect("../error.jsp?type=account");
    	}
%>