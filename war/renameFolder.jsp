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
if(session.getAttribute("iduser") != null && request.getParameter("path") != null && session.getAttribute("typelog") != null && request.getParameter("name") != null && request.getParameter("rename") != null){
	ProcessData pd = new ProcessData();

	String iduser = (String) session.getAttribute("iduser");
	
	String path = (String) request.getParameter("path");
	session.setAttribute("path", path);
	String typelog = (String) session.getAttribute("typelog");
	
	String[] pathString = pd.getPath(path);
	
	int level = pd.getLevel(path);
	
	String name = request.getParameter("name");
	
	String rename = request.getParameter("rename");
	
	String logName = "nameFolder";
	if(ProcessData.checkString(rename)){
    	
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key logKey = KeyFactory.createKey("keyFolder", logName);
	//rename thư mục chọn
	Query query = new Query("folder", logKey).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, path).addFilter("name", Query.FilterOperator.EQUAL, name).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	List<Entity> folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	int tempShare = 0;
	
	if(!folders.isEmpty()) {
		for (Entity folder : folders) {
			Key tempKey = folder.getKey();
			datastore.delete(tempKey);
			folder.setProperty("name", rename);
			datastore.put(folder);
		}
	}
	//repath các thư mục con, cháu ....
	query = new Query("folder", logKey).addSort("level", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("level", Query.FilterOperator.GREATER_THAN, level).addFilter("typelog", Query.FilterOperator.EQUAL, typelog);
	folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	if(!folders.isEmpty()) {
		for (Entity folder : folders) {
			String pathTemp = String.valueOf(folder.getProperty("path"));
			String[] pathStringTemp = pd.getPath(pathTemp);
			int levelTemp = pd.getLevel(pathTemp);
			int delete = -1;
			String rePath = "";
			for(int i=0; i<=level; i++){
				if(pathString[i].compareTo(pathStringTemp[i]) == 0){
					delete++;
					rePath += pathString[i] + "/";
				}
			}
			if(name.compareTo(pathStringTemp[level+1]) == 0){
				delete++;
				rePath += rename;
			}
			
			if(delete == level+1){
				for(int i=delete+1; i<=levelTemp; i++){
					path += "/" + pathStringTemp[i];
				}
				Key tempKey = folder.getKey();
				datastore.delete(tempKey);
				folder.setProperty("path", rePath);
				datastore.put(folder);
			}
		}
	}
	
	//repath file con
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
			String rePath = "";
			for(int i=0; i<=level; i++){
				if(pathString[i].compareTo(pathStringTemp[i]) == 0){
					delete++;
					rePath += pathString[i] + "/";
				}
			}
			if(name.compareTo(pathStringTemp[level+1]) == 0){
				delete++;
				rePath += rename;
			}
			
			if(delete == level+1){
				for(int i=delete+1; i<=levelTemp; i++){
					path += "/" + pathStringTemp[i];
				}
				Key tempKey = file.getKey();
				datastore.delete(tempKey);
				file.setProperty("path", rePath);
				datastore.put(file);
			}
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