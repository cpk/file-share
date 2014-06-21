package code;

import java.util.List;

import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("unused")
public class getfoldertree{
	public String html = "";
	String logName = "nameFolder";
	int lvfolder = 0;
	String iduser = "";
	String path = "root";
	String typelog = "0";
	DatastoreService datastore;
	Key logKey;
	Query query;
	List<Entity> folders;
	ProcessData pd = new ProcessData();
	
	public getfoldertree(String user, String typelog){
		this.iduser = user;
		this.typelog = typelog;
		datastore = DatastoreServiceFactory.getDatastoreService();
	    logKey = KeyFactory.createKey("keyFolder", logName);
		
	    query = new Query("folder", logKey).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, this.iduser);
	    folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	}
	
    public String deQuy(String path, int lv, String[] pathString){
    	this.lvfolder = pathString.length;
    	String html = "";
    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    	Key logKey = KeyFactory.createKey("keyFolder", logName);
		
    	Query query = new Query("folder", logKey).addSort(
    			"name", Query.SortDirection.ASCENDING).addFilter(
    			"iduser", Query.FilterOperator.EQUAL, this.iduser).addFilter(
    	    	"path", Query.FilterOperator.EQUAL, path).addFilter(
    	    	"typelog", Query.FilterOperator.EQUAL, typelog);
    	List<Entity> folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
    	int dem = 0;
    	if(dem == 0){
			html += "<ul>\n\t";
		}
    	if (!folders.isEmpty()) {
    		
	    	for (Entity folder : folders) {
	    		String namefolder = String.valueOf(folder.getProperty("name"));
	    		
	    		String pathFolder = String.valueOf(folder.getProperty("path")) + "/" + namefolder;
	    		html += "<li> <div class='lili'  onClick='goFolder(\"" + pathFolder + "\");'> <img  src='img/icon/foldertree.png' width='20' height='30' style='margin-bottom:-7px;' title='"+ namefolder +"' />" + ProcessData.changeString(namefolder) + "</div></li>\n\t";
	    		lv++;
	    		if(lv < this.lvfolder && this.lvfolder > 1){
		    		String tempPath = path + "/" + pathString[lv];
		    		String tempPathNow = path + "/" + namefolder;
		    		if(tempPath.compareTo(tempPathNow) == 0 ){	    			
		    			
		    			html += deQuy(tempPath, lv, pathString);	    			
		    		}
	    		}
	    		lv--;
	    		dem++;
	    		
	    	}
    	}
    	Key logKey2 = KeyFactory.createKey("keyFile", "nameFile");
		
    	Query query2 = new Query("file", logKey2).addSort(
    			"name", Query.SortDirection.ASCENDING).addFilter(
    			"iduser", Query.FilterOperator.EQUAL, this.iduser).addFilter(
    	    	"path", Query.FilterOperator.EQUAL, path).addFilter(
    	    	"typelog", Query.FilterOperator.EQUAL, typelog);
    	List<Entity> files = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(13091991));
    	if (!files.isEmpty()) {    		
	    	for (Entity file : files) {
	    		String namefile = String.valueOf(file.getProperty("name"));
	    		String key = String.valueOf(file.getProperty("key"));	  
	    		String pathfile = String.valueOf(file.getProperty("path")) + "/" + namefile;
	    		html += "<li> <div class='lili'  onClick='window.location = \"/serve?blob-key="+ key + "\"'> <img  src='img/icon/file.png' width='20' height='30' style='margin-bottom:-7px;' title='"+ namefile +"' />" + ProcessData.changeString(namefile) + "</div></li>\n\t";
	    		
	    	}
    	}
    	if(dem == folders.size()){
			html += "</ul>";
		}
    	return html;
    }
    
    public String deQuyShare(String path, int lv, String[] pathString){
    	this.lvfolder = pathString.length;
    	String html = "";
    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    	Key logKey = KeyFactory.createKey("keyFolder", logName);
		
    	Query query = new Query("folder", logKey).addSort(
    			"name", Query.SortDirection.ASCENDING).addFilter(
    			"iduser", Query.FilterOperator.EQUAL, this.iduser).addFilter(
    	    	"path", Query.FilterOperator.EQUAL, path).addFilter(
    	    	"typelog", Query.FilterOperator.EQUAL, typelog);
    	List<Entity> folders = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
    	int dem = 0;
    	if(dem == 0){
			html += "<ul>\n\t";
		}
    	if (!folders.isEmpty()) {
    		
	    	for (Entity folder : folders) {
	    		String namefolder = String.valueOf(folder.getProperty("name"));
	    		
	    		String pathFolder = String.valueOf(folder.getProperty("path")) + "/" + namefolder;
	    		html += "<li> <div class='lili'  onClick='goFolderShare(\"" + pathFolder + "\");'> <img  src='img/icon/foldertree.png' width='20' height='30' style='margin-bottom:-7px;' title='"+ namefolder +"' />" + ProcessData.changeString(namefolder) + "</div></li>\n\t";
	    		lv++;
	    		if(lv < this.lvfolder && this.lvfolder > 1){
		    		String tempPath = path + "/" + pathString[lv];
		    		String tempPathNow = path + "/" + namefolder;
		    		if(tempPath.compareTo(tempPathNow) == 0 ){	    			
		    			
		    			html += deQuyShare(tempPath, lv, pathString);	    			
		    		}
	    		}
	    		lv--;
	    		dem++;
	    		
	    	}
    	}
    	Key logKey2 = KeyFactory.createKey("keyFile", "nameFile");
		
    	Query query2 = new Query("file", logKey2).addSort(
    			"name", Query.SortDirection.ASCENDING).addFilter(
    			"iduser", Query.FilterOperator.EQUAL, this.iduser).addFilter(
    	    	"path", Query.FilterOperator.EQUAL, path).addFilter(
    	    	"typelog", Query.FilterOperator.EQUAL, typelog);
    	List<Entity> files = datastore.prepare(query2).asList(FetchOptions.Builder.withLimit(13091991));
    	if (!files.isEmpty()) {    		
	    	for (Entity file : files) {
	    		String namefile = String.valueOf(file.getProperty("name"));
	    		String key = String.valueOf(file.getProperty("key"));	  
	    		String pathfile = String.valueOf(file.getProperty("path")) + "/" + namefile;
	    		html += "<li> <div class='lili'  onClick='window.location = \"/serve?blob-key="+ key + "\"'> <img  src='img/icon/file.png' width='20' height='30' style='margin-bottom:-7px;' title='"+ namefile +"' />" + ProcessData.changeString(namefile) + "</div></li>\n\t";
	    		
	    	}
    	}
    	if(dem == folders.size()){
			html += "</ul>";
		}
    	return html;
    }
}