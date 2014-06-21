<%
	String path = request.getParameter("pathFolder");
	if(request.getParameter("pathFolder") != null && session.getAttribute("pathshare") != null){
	session.removeValue("pathshare");
    session.setAttribute("pathshare",path);
%>

<%= path %>
<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>