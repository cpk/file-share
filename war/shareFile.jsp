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
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.List" %>
<%@ page import="code.getfoldertree" %>
<%@ page import="code.ProcessData" %>
<%@ page import="com.google.appengine.api.blobstore.BlobKey" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%

if(session.getAttribute("iduser") != null && request.getParameter("path") != null && session.getAttribute("typelog") != null && request.getParameter("name") != null && request.getParameter("keyShare") != null){
	ProcessData pd = new ProcessData();

	String iduser = (String) session.getAttribute("iduser");
	
	String path = (String) request.getParameter("path");
	session.setAttribute("path", path);
	
	String typelog = (String) session.getAttribute("typelog");
	
	String[] pathString = pd.getPath(path);
	
	int level = pd.getLevel(path);
	
	String name = request.getParameter("name");
	
	String keyShare = request.getParameter("keyShare");
	
	String logName = "nameFile";
	
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key logKey = KeyFactory.createKey("keyFile", logName);
	
	Query query = new Query("file", logKey).addSort("level", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("key", Query.FilterOperator.EQUAL, name);
	List<Entity> files = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	if(!files.isEmpty()) {
		for (Entity file : files) {
			//xóa file
			Key tempKey = file.getKey();
			
			datastore.delete(tempKey);
			int share = Integer.parseInt(String.valueOf(file.getProperty("share")));
			if(share == 0){
				file.setProperty("share", 1);
				String logNameShare = "nameShare";
				Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
				Entity log = new Entity("share", logKeyShare);
				log.setProperty("iduser", iduser);
				log.setProperty("root", path);
				log.setProperty("name", String.valueOf(file.getProperty("key")));
				log.setProperty("type", 1);
				log.setProperty("typelog", typelog);
				log.setProperty("keyShare", keyShare);
				datastore.put(log);
			}else{
				String logNameShare = "nameShare";
				Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
				Query queryShare = new Query("share", logKeyShare).addFilter("keyShare", Query.FilterOperator.EQUAL, keyShare);
				List<Entity> sharesEntity = datastore.prepare(queryShare).asList(FetchOptions.Builder.withLimit(13091991));
				if(!sharesEntity.isEmpty()) {
					for (Entity shareEntity : sharesEntity) {
						Key tempKeyShare = shareEntity.getKey();
						datastore.delete(tempKeyShare);
					}
				}
				file.setProperty("share", 0);
			}
			datastore.put(file);
			
		}
	}
	//show lại
	
%>
<%@ include file="/show.jsp" %>
<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>