<%
	String path = request.getParameter("pathFolder");
	if(request.getParameter("pathFolder") != null && session.getAttribute("path") != null){
	session.removeValue("path");
    session.setAttribute("path",path);
%>

<%= path %>
<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>