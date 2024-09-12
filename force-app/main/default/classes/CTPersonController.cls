Public with sharing class CTPersonController{
     
     public static String getToken(String mobileNO){
          Blob value = Blob.valueOf(mobileNO);
          Blob hash = Crypto.generateDigest ('MD5' , value);

          //get the string value of hash blob
          return EncodingUtil.base64Encode(hash);
       }
}