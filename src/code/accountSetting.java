package code;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;


public class accountSetting extends HttpServlet {

	private static final Logger log = Logger.getLogger(signin.class.getName());

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
    	HttpSession session = req.getSession(true);
    	String emailCheck = String.valueOf(session.getAttribute("iduser"));
    	boolean check = false;
		if(session.getAttribute("typelog") != null){
			int typelogCheck = Integer.parseInt(String.valueOf(session.getAttribute("typelog")));
	    	if(typelogCheck == 0){
		    	check = true;
	    	}else{
				res.sendRedirect("../error.jsp?type=type");
			}
		}else{
			res.sendRedirect("../error.jsp?type=login");
    	}
    	if(check){
	    	
	    	String firstname = req.getParameter("firstname");
	    	String lastname = req.getParameter("lastname");
	        
	    	String email = emailCheck;
	    	String password = req.getParameter("password");
	    	Md5 md5 = new Md5(password);		        	    	
	    	String md5Share = md5.getMd5();
	    	
	    	String logNameUser = "nameUser";
			DatastoreService datastoreUser = DatastoreServiceFactory.getDatastoreService();
			Key logKeyUser = KeyFactory.createKey("keyUser", logNameUser);
			Query queryUser = new Query("user", logKeyUser).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, email);
			List<Entity> users = datastoreUser.prepare(queryUser).asList(FetchOptions.Builder.withLimit(13091991));
			if(!users.isEmpty()) {
				for (Entity user : users) {
					Key key = user.getKey();
					datastoreUser.delete(key);
					user.setProperty("firstname", firstname);
					user.setProperty("lastname", lastname);
					user.setProperty("password", md5Share);
					datastoreUser.put(user);
				}
			}
			res.sendRedirect("/user.jsp");			
	    }else{
			res.sendRedirect("/error.jsp?type=account");
		}
    }
    
}
    