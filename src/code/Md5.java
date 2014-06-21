package code;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;



public class Md5{
	String text;
	
	public Md5(String text){
		this.text = text;
	}
	
	private static String convertedToHex(byte[] data) 
    { 
        StringBuffer buf = new StringBuffer();
        
        for (int i = 0; i < data.length; i++) 
        { 
            int halfOfByte = (data[i] >>> 4) & 0x0F;
            int twoHalfBytes = 0;
            
            do 
            { 
                if ((0 <= halfOfByte) && (halfOfByte <= 9)) 
                {
                    buf.append( (char) ('0' + halfOfByte) );
                }
                
                else 
                {
                    buf.append( (char) ('a' + (halfOfByte - 10)) );
                }

                halfOfByte = data[i] & 0x0F;

            } while(twoHalfBytes++ < 1);
        } 
        return buf.toString();
    } 

    public static String MD5(String text) 
    throws NoSuchAlgorithmException, UnsupportedEncodingException  
    { 
        MessageDigest md;
        md = MessageDigest.getInstance("MD5");
        byte[] md5 = new byte[64];
        md.update(text.getBytes("iso-8859-1"), 0, text.length());
        md5 = md.digest();        
        return convertedToHex(md5);
    }
    
    
    public String getMd5(){
    	try {
			text = MD5(this.text);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return this.text;
    }
}