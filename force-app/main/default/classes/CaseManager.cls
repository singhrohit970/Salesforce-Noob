@RestResource(urlMapping='/Cases1/*')    //declare it as global
global with sharing class CaseManager {
@HttpGet
    global static Case getCaseById(){   //method
        RestRequest request=RestContext.request;
      String caseId=  request.requestURI.substring(request.requestURI.lastIndexof('/')+1);
       Case result= [Select CaseNumber,Subject,Origin,Priority from Case where ID=:caseId];
            return result;
    }

}