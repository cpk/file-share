package code;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

import java.util.List;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

public class Upload extends HttpServlet {
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		Map<String, List<BlobInfo>> blobsInfo = blobstoreService.getBlobInfos(req);

		List<BlobKey> blobKey = blobs.get("myFile");
		List<BlobInfo> blobInfo = blobsInfo.get("myFile");
		if(blobInfo != null)
			for(int j=0; j<blobInfo.size() ; j++){
				BlobKey blobKeyTemp = blobKey.get(j);
				BlobInfo blobInfoTemp = blobInfo.get(j);
				if (blobKeyTemp == null) {
					res.sendRedirect("/user.jsp");
				} else {
					HttpSession session = req.getSession(true);
					String iduser = (String) session.getAttribute("iduser");
					String namefile =  blobInfoTemp.getFilename();
					String type =  blobInfoTemp.getContentType();
					String typelog =  (String) session.getAttribute("typelog");
					String path = (String) session.getAttribute("path");
					ProcessData pd = new ProcessData();
					int level = pd.getLevel(path);
					String key = blobKeyTemp.getKeyString();
					String logName = "nameFile";

					DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
					Key logKey = KeyFactory.createKey("keyFile", logName);


					Entity log = new Entity("file", logKey);
					log.setProperty("name", namefile);
					log.setProperty("type", type);
					log.setProperty("iduser", iduser);
					log.setProperty("path", path);
					log.setProperty("level", level);
					log.setProperty("key", key);
					log.setProperty("typelog", typelog);
					String shareString = new String();
					shareString = iduser + "*" + path + "*" + namefile + "*" + typelog + "*";

					Md5 md5 = new Md5(shareString);

					String md5Share = md5.getMd5();
					if(level > 0){
						String pathParent = "root";
						String[] pathString = pd.getPath(path);
						for(int i=1; i<level; i++){
							pathParent += "/" + pathString[i];
						}
						String logNameTemp = "nameFolder";
						Key logKeyTemp = KeyFactory.createKey("keyFolder", logNameTemp);
						Query queryTemp = new Query("folder", logKeyTemp).addSort("name", Query.SortDirection.ASCENDING).addFilter("iduser", Query.FilterOperator.EQUAL, iduser).addFilter("path", Query.FilterOperator.EQUAL, pathParent).addFilter("name", Query.FilterOperator.EQUAL, pathString[level]);
						List<Entity> logsTemp = datastore.prepare(queryTemp).asList(FetchOptions.Builder.withLimit(13091991));

						if (!logsTemp.isEmpty()) {
							for (Entity folder : logsTemp) {
								int share = Integer.parseInt(String.valueOf(folder.getProperty("share")));    						
								if(share == 0){
									log.setProperty("share", 0);
								}else{
									log.setProperty("share", 1);
									String logNameShare = "nameShare";
									Key logKeyShare = KeyFactory.createKey("keyShare", logNameShare);
									Entity shareTemp = new Entity("share", logKeyShare);
									shareTemp.setProperty("iduser", iduser);
									shareTemp.setProperty("root", path);
									shareTemp.setProperty("name", namefile);
									shareTemp.setProperty("type", 1);
									shareTemp.setProperty("typelog", typelog);
									shareTemp.setProperty("keyShare", md5Share);
									datastore.put(shareTemp);
								}
							}
						}
					}else{
						log.setProperty("share", 0);
					}
					datastore.put(log);
					res.sendRedirect("/user.jsp");

				}
			}
		if(blobs.size() <= 0){
			res.sendRedirect("/user.jsp");
		}
	}
}