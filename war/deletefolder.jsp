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
	
	String logName = "nameFolder";
	
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
    	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key logKey = KeyFactory.createKey("keyFolder", logName);
	//xóa các thư mục con, cháu ....
	Query query = new Query("folder", logKey).addSort("level", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("level", Query.FilterOperator.GREATER_THAN, level).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	List<Entity> folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	if(!folders.isEmpty()) {
		for (Entity folder : folders) {
			String pathTemp = String.valueOf(folder.getProperty("path"));
			String[] pathStringTemp = pd.getPath(pathTemp);
			int levelTemp = pd.getLevel(pathTemp);
			int delete = -1;
			for(int i=0; i<=level; i++){
				if(pathString[i].compareTo(pathStringTemp[i]) == 0){
					delete++;
				}
			}
			if(name.compareTo(pathStringTemp[level+1]) == 0){
				delete++;
			}
			
			if(delete == level+1){
				int shareTemp = Integer.parseInt(String.valueOf(folder.getProperty("share")));
				if(shareTemp == 1){
					String keyShare = String.valueOf(folder.getProperty("iduser")) + "*" + String.valueOf(folder.getProperty("path")) + "*" + String.valueOf(folder.getProperty("name")) + "*" + String.valueOf(folder.getProperty("typelog")) + "*";
				
					Md5 md5 = new Md5(keyShare);
		
					String md5Share = md5.getMd5();
					
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
				//delete
				
				Key tempKey = folder.getKey();
				datastore.delete(tempKey);
			}
		}
	}
	//xóa thư mục chọn
	query = new Query("folder", logKey).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("name", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	
	if(!folders.isEmpty()) {
		for (Entity folder : folders) {
			int shareTemp = Integer.parseInt(String.valueOf(folder.getProperty("share")));
			if(shareTemp == 1){
				String keyShare = String.valueOf(folder.getProperty("iduser")) + "*" + String.valueOf(folder.getProperty("path")) + "*" + String.valueOf(folder.getProperty("name")) + "*" + String.valueOf(folder.getProperty("typelog")) + "*";
			
				Md5 md5 = new Md5(keyShare);
	
				String md5Share = md5.getMd5();
				
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
			Key tempKey = folder.getKey();
			
			datastore.delete(tempKey);
		}
	}
	//xóa file con
	logName = "nameFile";	
	logKey = KeyFactory.createKey("keyFile", logName);
	query = new Query("file", logKey).addSort("level", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("level", Query.FilterOperator.GREATER_THAN, level).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	List<Entity> files = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	if(!files.isEmpty()) {
		for (Entity file : files) {
			String pathTemp = String.valueOf(file.getProperty("path"));
			String[] pathStringTemp = pd.getPath(pathTemp);
			int levelTemp = pd.getLevel(pathTemp);
			int delete = -1;
			for(int i=0; i<=level; i++){
				if(pathString[i].compareTo(pathStringTemp[i]) == 0){
					delete++;
				}
			}
			if(name.compareTo(pathStringTemp[level+1]) == 0){
				delete++;
			}
			
			if(delete == level+1){
				int shareTemp = Integer.parseInt(String.valueOf(file.getProperty("share")));
				if(shareTemp == 1){
					String keyShare = String.valueOf(file.getProperty("iduser")) + "*" + String.valueOf(file.getProperty("path")) + "*" + String.valueOf(file.getProperty("name")) + "*" + String.valueOf(file.getProperty("typelog")) + "*";
				
					Md5 md5 = new Md5(keyShare);
		
					String md5Share = md5.getMd5();
					
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
				//delete	
				Key tempKey = file.getKey();
				datastore.delete(tempKey);
				String keyBlob = String.valueOf(file.getProperty("key"));
				//xóa nội dung file
				BlobKey blobKey = new BlobKey(keyBlob);
        		blobstoreService.delete(blobKey);
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