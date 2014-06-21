package code;

import java.util.List;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

public class ProcessData{
	String logName = "";
	String kindLogKey = "";
	String kindQuery = "";
	String kindSoft = "";
	String kindFilter = "";
	String valueFilter = "";
	

	public ProcessData(){
	}
	
	public ProcessData(String logName, String kindLogKey, String kindQuery, 
			String kindSoft, String kindFilter, String valueFilter){
this.logName = logName;
this.kindLogKey = kindLogKey;
this.kindQuery = kindQuery;
this.kindSoft = kindSoft;
this.kindFilter = kindFilter;
this.valueFilter = valueFilter;
}
	
	public List<Entity> getData(){
	
		Key logKey = KeyFactory.createKey(this.kindLogKey, this.logName);
    	
    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
	    Query query = new Query(this.kindQuery, logKey).addSort(this.kindSoft, Query.SortDirection.ASCENDING).addFilter(this.kindFilter, Query.FilterOperator.EQUAL, this.valueFilter);;
	    List<Entity> entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(13091991));
	    
		return entity;
	}
	
	public int getLevel(String path){
		int lvFolder = 0;
		for(int i=0; i<path.length(); i++)
			if(path.charAt(i) == '/' && i != path.length() - 1)
				lvFolder++;
		return lvFolder;
	}
	
	public String[] getPath(String path){
		int lvFolder = 0;
		for(int i=0; i<path.length(); i++)
			if(path.charAt(i) == '/' && i != path.length() - 1)
				lvFolder++;
		int dem = 0;
		int[] pathInt = new int[lvFolder];
		for(int i=0; i<path.length(); i++)
			if(path.charAt(i) == '/'){
				if(i != path.length() - 1)
					pathInt[dem] = i;
				dem++;
			}
		lvFolder++;
		String[] pathString = new String[lvFolder];
		for(int i=0; i<pathString.length; i++){
			if(i == 0){
				if(lvFolder == 1)
					pathString[i] = path;
				else
					pathString[i] = path.substring(0, pathInt[i]);				
			}else{
				if(i == pathString.length - 1){
					pathString[i] = path.substring(pathInt[i-1]+1, path.length());
				}else{
					pathString[i] = path.substring(pathInt[i-1]+1, pathInt[i]);
				}
			}
		}		
		return pathString;
	}
	
	public String setPath(String[] pathString){
		String path = "";
		for(int i=0; i<pathString.length; i++){
			if(i == 0){
				path += pathString[i];
			}else{
				path += "/" + pathString[i];
			}
		}
		return path;
	}
	
	public String[] getInfo(String keyShare){
		String[] info = new String[3];
		int vet = 0;
		int dem = 0;
		for(int i=0; i<keyShare.length(); i++){
			if(keyShare.charAt(i) == '*'){				
				info[dem] = keyShare.substring(vet, i);
				vet = i + 1;
				System.out.println(info[dem]);
				dem++;
				
			}
		}
		
		return info;
	}
	
	public static String[] getDataFile(String file){
		String[] info = new String[3];
		boolean con = true;
		for(int i=file.length()-1; i>=0; i--){
			if(file.charAt(i) == '.' && con){				
				info[1] = file.substring(i+1, file.length());
				con = false;
			}
			if(file.charAt(i) == 92){				
				info[0] = file.substring(i+1, file.length());
				i = -1;
			}
		}
		
		return info;
	}
	
	public boolean checkEmail(String email){
		int dem = 0;
		for(int i=email.length()-1; i>=0; i--){
			if(email.charAt(i) == '.'){				
				dem++;
				i = -1;
			}
		}
		for(int i=0; i<email.length(); i++){
			if(email.charAt(i) == '@'){				
				dem++;
			}
		}
		if(dem == 2){
			return true;
		}
		return false;
	}
	public static boolean checkString(String name){
		for(int i=name.length()-1; i>=0; i--){
			if(name.charAt(i) == 92 || 
					name.charAt(i) == 47 ||
					name.charAt(i) == 39 ||
					name.charAt(i) == 34 ||
					name.charAt(i) == 42 ||
					name.charAt(i) == 124 ||
					name.charAt(i) == '<' ||
					name.charAt(i) == '>' ||
					name.charAt(i) == 27 ||
					name.charAt(i) == 22 ||
					name.charAt(i) == 22){				
				return false;
			}
		}
		if(name.length() > 255 || name.length() <= 0){
			return false;
		}
		return true;
	}
	public static String changeString(String name){
		if(name.length() > 10)
			return name.substring(0,10)+"...";
		return name;
	}
	
	
}