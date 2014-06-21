<%@ page import="code.ProcessData" %>
<%
if(session.getAttribute("pathshare") != null && session.getAttribute("rootshare") != null){

	String path = (String) session.getAttribute("pathshare");
	String root = (String) session.getAttribute("rootshare");
		
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
	session.removeValue("pathshare");
    session.setAttribute("pathshare",path);
%>
<%= path %>

<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>