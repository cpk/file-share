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
	
	String logName = "nameFolder";
    	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key logKey = KeyFactory.createKey("keyFolder", logName);
	//share thư mục chọn
	Query query = new Query("folder", logKey).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("name", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	List<Entity> folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	int tempShare = 0;
	
	if(!folders.isEmpty()) {
		for (Entity folder : folders) {
			Key tempKey = folder.getKey();
			int share = Integer.parseInt(String.valueOf(folder.getProperty("share")));
			datastore.delete(tempKey);
			if(share == 0){
				folder.setProperty("share", 1);
				tempShare = 1;
				String logNameShare = "nameShare";
				Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
				Entity log = new Entity("share", logKeyShare);
				log.setProperty("iduser", iduser);
				log.setProperty("root", path);
				log.setProperty("name", String.valueOf(folder.getProperty("name")));
				log.setProperty("type", 0);
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
				folder.setProperty("share", 0);
				tempShare = 0;
			}
			
			datastore.put(folder);
		}
	}
	//share các thư mục con, cháu ....
	query = new Query("folder", logKey).addSort("level", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("level", Query.FilterOperator.GREATER_THAN, level).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	if(!folders.isEmpty()) {
		for (Entity folder : folders) {
			String pathTemp = String.valueOf(folder.getProperty("path"));
			String[] pathStringTemp = pd.getPath(pathTemp);
			int levelTemp = pd.getLevel(pathTemp);
			int share = Integer.parseInt(String.valueOf(folder.getProperty("share")));
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
				//delete	
				Key tempKey = folder.getKey();
				datastore.delete(tempKey);
				String keyShareTemp = String.valueOf(folder.getProperty("iduser")) + "*" +
										String.valueOf(folder.getProperty("path")) + "*" +
										String.valueOf(folder.getProperty("name")) + "*" +
										String.valueOf(folder.getProperty("typelog")) + "*";
				Md5 md5 = new Md5(keyShareTemp);

				String md5Share = md5.getMd5();	
				if(tempShare == 1 && share == 0){
					folder.setProperty("share", 1);
					String logNameShare = "nameShare";
					Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
					Entity log = new Entity("share", logKeyShare);
					log.setProperty("iduser", iduser);
					log.setProperty("root", path);
					log.setProperty("name", String.valueOf(folder.getProperty("name")));
					log.setProperty("type", 0);
					log.setProperty("typelog", typelog);
					
					log.setProperty("keyShare", md5Share);
					datastore.put(log);					
				}else{
					if(tempShare == 0 && share == 1){
						folder.setProperty("share", 0);
						String logNameShare = "nameShare";
						Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
						Query queryShare = new Query("share", logKeyShare).addFilter("keyShare", Query.FilterOperator.EQUAL, md5Share);
						List<Entity> sharesEntity = datastore.prepare(queryShare).asList(FetchOptions.Builder.withLimit(13091991));
						if(!sharesEntity.isEmpty()) {
							for (Entity shareEntity : sharesEntity) {
								Key tempKeyShare = shareEntity.getKey();
								datastore.delete(tempKeyShare);
							}
						}
					}
				}
				datastore.put(folder);
			}
		}
	}
	
	//share file con
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
			int share = Integer.parseInt(String.valueOf(file.getProperty("share")));
			for(int i=0; i<=level; i++){
				if(pathString[i].compareTo(pathStringTemp[i]) == 0){
					delete++;
				}
			}
			if(name.compareTo(pathStringTemp[level+1]) == 0){
				delete++;
			}
			
			if(delete == level+1){
				//delete	
				Key tempKey = file.getKey();
				datastore.delete(tempKey);
				String keyShareTemp = String.valueOf(file.getProperty("iduser")) + "*" +
										String.valueOf(file.getProperty("path")) + "*" +
										String.valueOf(file.getProperty("name")) + "*" +
										String.valueOf(file.getProperty("typelog")) + "*";
				Md5 md5 = new Md5(keyShareTemp);

				String md5Share = md5.getMd5();	
				if(tempShare == 1 && share == 0){
					file.setProperty("share", 1);
					String logNameShare = "nameShare";
					Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
					Entity log = new Entity("share", logKeyShare);
					log.setProperty("iduser", iduser);
					log.setProperty("root", path);
					log.setProperty("name", String.valueOf(file.getProperty("name")));
					log.setProperty("type", 1);
					log.setProperty("typelog", typelog);
					log.setProperty("keyShare", md5Share);
					datastore.put(log);
				}else{
					if(tempShare == 0 && share == 1){
						file.setProperty("share", 0);
						String logNameShare = "nameShare";
						Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
						Query queryShare = new Query("share", logKeyShare).addFilter("keyShare", Query.FilterOperator.EQUAL, md5Share);
						List<Entity> sharesEntity = datastore.prepare(queryShare).asList(FetchOptions.Builder.withLimit(13091991));
						if(!sharesEntity.isEmpty()) {
							for (Entity shareEntity : sharesEntity) {
								Key tempKeyShare = shareEntity.getKey();
								datastore.delete(tempKeyShare);
							}
						}
					}
				}
				datastore.put(file);
			}
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