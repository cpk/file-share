package code;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.List;

import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;


public class signin extends HttpServlet {

	private static final Logger log = Logger.getLogger(signin.class.getName());

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	if(req.getParameter("firstname") != null &&
    			req.getParameter("lastname") != null &&
    			req.getParameter("email") != null &&
    			req.getParameter("reemail") != null &&
    			req.getParameter("password") != null &&
    			req.getParameter("repassword") != null){
    	
    	String firstname = req.getParameter("firstname");
    	String lastname = req.getParameter("lastname");
    	String email = req.getParameter("email");
    	String reemail = req.getParameter("reemail");
    	String password = req.getParameter("password");
    	String repassword = req.getParameter("repassword");
    	ProcessData pd = new ProcessData();
    	if(!pd.checkEmail(email)){
    		resp.sendRedirect("/signin.jsp?error=email");
    	}else{
	    	if(email.compareTo(reemail) != 0 ){
	    		resp.sendRedirect("/signin.jsp?error=reemail");
	    	}else{
	    		if(password.length() < 6){
	    			resp.sendRedirect("/signin.jsp?error=pass");
	    		}else{
		    		if(password.compareTo(repassword) != 0 ){
		        		resp.sendRedirect("/signin.jsp?error=repass");
		        	}else{
		        		String level = "0";
		            	
		            	String logName = "nameUser";
		            	Key logKey = KeyFactory.createKey("keyUser", logName);
		            	
		            	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		        		
		        	    Query query = new Query("user", logKey).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, email);
		        	    List<Entity> logs = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
		        	    
		        	    int temp=0;
		        	    if (!logs.isEmpty()) {
		        	    	resp.sendRedirect("/signin.jsp?error=exitsemail");
		        	    }else{
		        	        Entity log = new Entity("user", logKey);
		        	        log.setProperty("firstname", firstname);
		        	        log.setProperty("lastname", lastname);
		        	        log.setProperty("email", email);
		        	        Md5 md5 = new Md5(password);		        	    	
		        	    	String md5Share = md5.getMd5();
		        	        log.setProperty("password", md5Share);
		        	        log.setProperty("level", level);	        
		        	        datastore.put(log);
		        	        HttpSession session = req.getSession(true);
		        	        session.setAttribute("iduser",email);
		                	session.setAttribute("lvfolder","0");
		                	session.setAttribute("path","root");
		                	session.setAttribute("root","root");
		                	session.setAttribute("typelog","0");
		        	        resp.sendRedirect("/user.jsp");
		            	}
		        	}
	    		}
	    	}
    	} 
    	}else{
    		resp.sendRedirect("/index.jsp");
    	}
    	
    }
	
}
