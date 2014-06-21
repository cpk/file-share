<%
	String foldername =  request.getParameter("foldername");	
	if(request.getParameter("foldername") != null && request.getParameter("path") != null){
	String path = (String) request.getParameter("path") + "/" + foldername;
	session.removeValue("pathshare");
    session.setAttribute("pathshare",path);
%>

<%= path %>

<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>
