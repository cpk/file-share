
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
<%@ page import="java.util.Vector" %>
<%@ page import="code.ProcessData" %>
<%@ page import="code.Md5" %>
<%
		String iduser = (String) session.getAttribute("iduser");
		String name =  request.getParameter("username");
		String path = (String) session.getAttribute("path");
		String typelog = (String) session.getAttribute("typelog");
		if(session.getAttribute("iduser") != null && session.getAttribute("path") != null && session.getAttribute("typelog") != null && request.getParameter("username") != null){
		ProcessData pd = new ProcessData();
		int level = pd.getLevel(path);
		String logName = "nameFolder";
    	if(ProcessData.checkString(name)){
			
    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key logKey = KeyFactory.createKey("keyFolder", logName);
		
	    Query query = new Query("folder", logKey).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("name", Query.FilterOperator.EQUAL, name);
	    List<Entity> logs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	   
	   
	    if (logs.isEmpty()) {
	    	Entity log = new Entity("folder", logKey);
	        log.setProperty("name", name);
	        log.setProperty("iduser", iduser);
	        log.setProperty("path", path);
			log.setProperty("level", level);		
			log.setProperty("typelog", typelog);	
			String shareString = new String();
			shareString = iduser + "*" + path + "*" + name + "*";
			
			Md5 md5 = new Md5(shareString);
			
			String md5Share = md5.getMd5();	
			if(level > 0){
				String pathParent = "root";
				String[] pathString = pd.getPath(path);
				for(int i=1; i<level; i++){
					pathParent += "/" + pathString[i];
				}
				Query queryTemp = new Query("folder", logKey).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, pathParent).addFilter("name", Query.FilterOperator.EQUAL, pathString[level]);
				List<Entity> logsTemp = datastore.prepare(queryTemp).asList(FetchOptions.Builder.withLimit(13091991));
		   		
		   		
				if (!logsTemp.isEmpty()) {
					for (Entity folder : logsTemp) {
						int share = Integer.parseInt(String.valueOf(folder.getProperty("share")));
						if(share == 0){
							log.setProperty("share", 0);
						}else{
							log.setProperty("share", 1);
							String logNameShare = "nameShare";
							Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
							Entity shareTemp = new Entity("share", logKeyShare);
							shareTemp.setProperty("iduser", iduser);
							shareTemp.setProperty("root", path);
							shareTemp.setProperty("name", name);
							shareTemp.setProperty("type", 0);
							shareTemp.setProperty("keyShare", md5Share);
							datastore.put(shareTemp);
						}
					}
				}
			}else{
				log.setProperty("share", 0);
			}
			
	        datastore.put(log);
	    }
		}
	    
%>
<%@ include file="/show.jsp" %>
<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>