<%@ page import="code.ProcessData" %>
<%
if(session.getAttribute("path") != null && session.getAttribute("root") != null){

	String path = (String) session.getAttribute("path");
	String root = (String) session.getAttribute("root");
		
	ProcessData pd = new ProcessData();
	String[] pathString = pd.getPath(path);
	int level = pd.getLevel(path);
	int levelroot = pd.getLevel(root);
	
	path = "";
	for(int i=0; i<pathString.length - 1; i++){
		if(i==0){
			path += pathString[i];
		}else{
			path += "/" + pathString[i];
		}
	}
	
	if(level == levelroot)
		path = root;
	session.removeValue("path");
    session.setAttribute("path",path);
%>
<%= path %>

<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>