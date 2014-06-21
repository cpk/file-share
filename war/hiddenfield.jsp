<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String message= (String)request.getParameter("message");
	if(message != null){
		if(message.compareTo("") == 0){
			%>
            <button class="submit button" type="submit">UPLOAD</button>
            <%	
		}else{
			%>
            <%= message %>
            <%	
		}
	}
%>
        
