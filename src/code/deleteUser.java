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

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;


public class deleteUser extends HttpServlet {

	private static final Logger log = Logger.getLogger(signin.class.getName());

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
    	
    	HttpSession session = req.getSession(true);
    	String emailCheck = String.valueOf(session.getAttribute("iduser"));
    	boolean check = false;
		if(session.getAttribute("typelog") != null){
			int typelogCheck = Integer.parseInt(String.valueOf(session.getAttribute("typelog")));
    	if(typelogCheck == 0){
	    	String logNameCheck = "nameUser";
	    	
	    	DatastoreService datastoreCheck = DatastoreServiceFactory.getDatastoreService();
		    Key logKeyCheck = KeyFactory.createKey("keyUser", logNameCheck);
		    Query query = new Query("user", logKeyCheck).addSort("email", Query.SortDirection.ASCENDING).addFilter("email", Query.FilterOperator.EQUAL, emailCheck);
		    List<Entity> logsCheck = datastoreCheck.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
		   
		    if (!logsCheck.isEmpty()) {
		    	for (Entity logCheck : logsCheck) {
		    		int levelCheck = Integer.parseInt(String.valueOf(logCheck.getProperty("level")));
		    		if(levelCheck == 1){
		    			check = true;
		    		}
		    	}
		    }
    	}else{
			res.sendRedirect("../error.jsp?type=type");
		}
	}else{
		res.sendRedirect("../error.jsp?type=login");
    	}
    	if(check){
    	
	    	long id = Long.valueOf(req.getParameter("id"));
	    	String logName = req.getParameter("parentName");
	    	String logKind = req.getParameter("parentKind");
	    	String kind = req.getParameter("kind");
	    	
	    	String keyFile = req.getParameter("key");
	    	
	    	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	    	
	    	Key key = KeyFactory.createKey(logKind, logName);
	    	Key parentKey = KeyFactory.createKey(key, kind, id);
	    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    	
	    	datastore.delete(parentKey);
	    	res.sendRedirect("/ADMIN-FilesShare/index.jsp?cpk=list_users");
	    	String keyBlob = String.valueOf(keyFile);
			
			BlobKey blobKey = new BlobKey(keyBlob);
			blobstoreService.delete(blobKey);
			
    	}else{
    		res.sendRedirect("/error.jsp?type=account");
    	}
    }
}