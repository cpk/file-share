package code;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class login extends HttpServlet {
	private static final Logger log = Logger.getLogger(login.class.getName());

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	if(req.getParameter("username") != null &&
    			req.getParameter("password") != null){
    	String user = req.getParameter("username");
    	String pass = req.getParameter("password");
    	String remenber = req.getParameter("remenber_me");
    	
    	Md5 md5 = new Md5(pass);		        	    	
    	String md5Share = md5.getMd5();
    	
    	String logName = "nameUser";
    	
    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    Key logKey = KeyFactory.createKey("keyUser", logName);
	    Query query = new Query("user", logKey).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, user).addFilter("password", Query.FilterOperator.EQUAL, md5Share);
	    List<Entity> logs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	   
	    if (!logs.isEmpty()) {
	    	HttpSession session = req.getSession(true);
	        session.setAttribute("iduser",user);
        	session.setAttribute("lvfolder","0");
        	session.setAttribute("path","root");
        	session.setAttribute("root","root");
        	session.setAttribute("typelog","0");
            resp.sendRedirect("/user.jsp");
            
	    }else{
            resp.sendRedirect("/index.jsp");
        }
    	}else{
			resp.sendRedirect("/index.jsp");
		}
    }
}