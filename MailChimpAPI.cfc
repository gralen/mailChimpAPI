/**
* @file  MailChimpAPI
* @author Jonathan Smith
* @description MailChimp v3 API Wrapper for Coldfusion (Railo 4.x, Lucee 5)
* 
* 
*/

component extends="APIHelpers" {
	public any function init(string apiKey,string serviceURL,numeric httpTimeout){
		super.init();
		setServiceURL(arguments.serviceURL);		
		setApiKey(arguments.apikey);
		if (Val(Arguments.httpTimeout) gt 0){
			setHttpTimeout(arguments.httpTimeout);
		}
		return this;
	}	
	public struct function getLists(debug){
		return apiCall("/lists","GET",Arguments.debug);
	}
	public struct function getListMembers(listId:string,debug){		
		return apiCall("/lists/#arguments.listId#/members","GET",Arguments.debug);		
	}
	public struct function manualAPICall(required string RESTEndPoint,required string method,required boolean debug){
		return apiCall(arguments.RESTEndPoint,arguments.method,arguments.debug);
	}
}