package code;

import java.util.List;

import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public class Search{
	public String html = "";
	String logName = "nameFolder";
	int lvfolder = 0;
	String iduser = "";
	String path = "root";
	String key = "";
	DatastoreService datastore;
	Key logKey;
	Query query;
	List<Entity> folders;
	ProcessData pd = new ProcessData();
	
	public Search(String user){
		this.iduser = user;
		datastore = DatastoreServiceFactory.getDatastoreService();
	    logKey = KeyFactory.createKey("keyFolder", logName);
		
	    query = new Query("folder", logKey).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, this.iduser);
	    folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	}
	
	public Search(String user, String path, String key){
		this.iduser = user;
		this.path = path;	
		this.key = key;
		ProcessData pd = new ProcessData();
		this.lvfolder = pd.getLevel(path);
	}
	
	public String deQuy(String path){
    	String html = "";
    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    	Key logKey = KeyFactory.createKey("keyFolder", logName);
    	
    	Query query = new Query("folder", logKey).addSort(
    			"name", Query.SortDirection.ASCENDING).addFilter(
    			"iduser", Query.FilterOperator.EQUAL, this.iduser).addFilter(
    	    	"path", Query.FilterOperator.EQUAL, path);
    	List<Entity> folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
    	
    	if (!folders.isEmpty()) {
    		
	    	for (Entity folder : folders) {
	    		String namefolder = String.valueOf(folder.getProperty("name"));
	    		if(namefolder.indexOf(key) > -1){
	    			String pathTemp = String.valueOf(folder.getProperty("path"));
	    			int share = Integer.parseInt(String.valueOf(folder.getProperty("share")));
	    			html += "<div class=\"box\"><input class=\"radiofile\" name=\"radiofile\" type=\"radio\" value=\""+ 
	    					namefolder +
	    					"\" onchange=\"option('"+
	    					namefolder+
	    					"','0','"+
	    					pathTemp+
	    					"');\"/> option<br /><img title=\""+ 
	    					namefolder +
	    					"\" src=\"img/icon/foldermain";
	    			if(share == 1){ 
	    				html+="share";
	    			} 
	    			html += ".png\" width=\"45\" height=\"70\"  onClick=\"openFolder('"+
			    			namefolder+
			    			"','"+
			    			pathTemp+
			    			"');\"/> <br />"+
			    			ProcessData.changeString(namefolder)+
			    			"</div>";
	    		}
	    		
		    		String tempPathNow = path + "/" + namefolder; 
		    		html += deQuy(tempPathNow);
	    		
	    		String pathFolder = String.valueOf(folder.getProperty("path")) + "/" + namefolder;
	    		
	    	}
    	}
    	Key logKey2 = KeyFactory.createKey("keyFile", "nameFile");
		
    	Query query2 = new Query("file", logKey2).addSort(
    			"name", Query.SortDirection.ASCENDING).addFilter(
    			"iduser", Query.FilterOperator.EQUAL, this.iduser).addFilter(
    	    	"path", Query.FilterOperator.EQUAL, path);
    	List<Entity> files = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(13091991));
    	if (!files.isEmpty()) {    		
	    	for (Entity file : files) {
	    		String namefile = String.valueOf(file.getProperty("name"));
	    		String key2 = String.valueOf(file.getProperty("key"));	  
	    		String pathfile = String.valueOf(file.getProperty("path")) + "/" + namefile;
	    		if(namefile.indexOf(key) > -1){	 
	    			String key  = new String();
	    			key = String.valueOf(file.getProperty("key"));
	    			String pathTemp = String.valueOf(file.getProperty("path"));
	    			int share = Integer.parseInt(String.valueOf(file.getProperty("share")));
	    			html += "<div class=\"box\"><input class=\"radiofile\" name=\"radiofile\" type=\"radio\" value=\""+ 
	    					namefile +
	    					"\" onchange=\"option('"+
	    					namefile+
	    					"','1','"+
	    					pathTemp+
	    					"');\"/> option<br /><img title=\""+ 
	    					namefile +
	    					"\" src=\"img/icon/file";
	    			if(share == 1){ 
	    				html+="share";
	    			} 
	    			html += ".png\" width=\"45\" height=\"70\"  onClick='window.location = \"/serve?blob-key="+
	    					key +
	    					"\"'/> <br />"+
			    			ProcessData.changeString(namefile)+
			    			"</div>";
	    		}
	    		
	    	}
    	}
    	return html;
	}
}