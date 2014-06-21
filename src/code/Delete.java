package code;

import javax.servlet.http.HttpServlet;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

public class Delete extends HttpServlet {
    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

    public void delete(String name){
    	
    	BlobKey blobKey = new BlobKey(name);
        blobstoreService.delete(blobKey);
        
    }
        
}