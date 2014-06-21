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
<%@ page import="code.Md5" %>
<%@ page import="com.google.appengine.api.blobstore.BlobKey" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%
	ProcessData pd = new ProcessData();

	String iduser = (String) session.getAttribute("iduser");
	
	String path = (String) request.getParameter("path");
	
	session.setAttribute("path", path);
	String typelog = (String) session.getAttribute("typelog");
	
	if(session.getAttribute("iduser") != null && request.getParameter("path") != null && session.getAttribute("typelog") != null ){
	String[] pathString = pd.getPath(path);
	
	int level = pd.getLevel(path);
	
	String name = request.getParameter("name");
	
	String logName = "nameFile";
	
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key logKey = KeyFactory.createKey("keyFile", logName);
	
	Query query = new Query("file", logKey).addSort("level", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("name", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	List<Entity> files = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	if(!files.isEmpty()) {
		for (Entity file : files) {
			String keyShare = String.valueOf(file.getProperty("iduser")) + "*" + String.valueOf(file.getProperty("path")) + "*" + String.valueOf(file.getProperty("name")) + "*" + String.valueOf(file.getProperty("typelog")) + "*";
			
			Md5 md5 = new Md5(keyShare);
	
			String md5Share = md5.getMd5();
			
			//xóa file
			Key tempKey = file.getKey();
			
			datastore.delete(tempKey);
			//xóa nội dung
			String keyBlob = String.valueOf(file.getProperty("key"));
				
			BlobKey blobKey = new BlobKey(keyBlob);
			blobstoreService.delete(blobKey);
			int shareTemp = Integer.parseInt(String.valueOf(file.getProperty("share")));
			if(shareTemp == 1){
				String logNameShare = "nameShare";
				Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
				Query queryShare = new Query("share", logKeyShare).addFilter("keyShare", Query.FilterOperator.EQUAL, md5Share);
				List<Entity> shares = datastore.prepare(queryShare).asList(FetchOptions.Builder.withLimit(13091991));
				if(!shares.isEmpty()) {
					for (Entity share : shares) {	
						Key tempKeyShare = share.getKey();
				
						datastore.delete(tempKeyShare);
					}
				}
			}
		}
	}
	%>
	
	<%@ include file="/show.jsp" %> 
<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>