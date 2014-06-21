package code;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

public class Serve extends HttpServlet {
    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws IOException {
	
		if(req.getParameter("blob-key") != null){
	        BlobKey blobKey = new BlobKey(req.getParameter("blob-key"));
	        BlobInfo blobInfo = new BlobInfoFactory().loadBlobInfo(blobKey);
	
	        res.addHeader("Content-Disposition", "filename='" + blobInfo.getFilename() + "'");
	        
	        blobstoreService.serve(blobKey, res);
		}else{
			res.sendRedirect("/index.jsp");
		}
    }
}