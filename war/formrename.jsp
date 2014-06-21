<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String namefolder = request.getParameter("name");
	String pathfolder = request.getParameter("path");
	if(request.getParameter("name") != null && request.getParameter("path") != null){
%>
<form onsubmit="return submitRename();" method="post" name="rename" class="rename">
	<div id="remane_input">
        <input name="rename" type="text" value="" size="50" onkeyup="checkRename(this.value,'<%= pathfolder %>');"/>
        <input name="name" type="hidden" value="<%= namefolder %>" size="50"/>
        <input name="path" type="hidden" value="<%= pathfolder %>" size="50"/>
    </div>
    <div id="remane_submit">
    	
    </div>
</form>
<%
}else{
		response.sendRedirect("/index.jsp");
	}
%>