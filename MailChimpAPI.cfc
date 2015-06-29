/**
* @file  MailChimpAPI
* @author Jonathan Smith
* @description MailChimp v3 API Wrapper for Coldfusion (Railo 4.x, Lucee 5)
* 
* 
*/

component extends="APIHelpers" {
	this.STATUS_SUBSCRIBED = "subscribed";
	this.STATUS_UNSUBSCRIBED = "unsubscribed";
	this.STATUS_CLEANED = "cleaned";

	public any function init(string apiKey,string serviceURL,numeric httpTimeout){
		super.init();
		setServiceURL(arguments.serviceURL);		
		setApiKey(arguments.apikey);
		if (Val(Arguments.httpTimeout) gt 0){
			setHttpTimeout(arguments.httpTimeout);
		}
		return this;
	}	
	public struct function getLists(boolean debug=false){
		return apiCall("/lists","GET",Arguments.debug);
	}
	public struct function getListMembers(required string listId,boolean debug=false){		
		return apiCall("/lists/#arguments.listId#/members","GET",{},Arguments.debug);		
	}

	// http://kb.mailchimp.com/api/article/how-to-manage-subscribers
	public struct function addMember(required string listId, required string email,required string status,required struct mergeFields){		
		var requestBody = {
			email_address = Arguments.email,
			status = Arguments.status,
			merge_fields = Arguments.mergeFields
		};
		return apiCall("/lists/#arguments.listId#/members","POST",requestBody,Arguments.debug);		
	}
	public any function getMember(required string listId, required string memberHash){		
		return apiCall("/lists/#arguments.listId#/members/#arguments.memberHash#","GET",{},Arguments.debug);
	}
	public struct function manualAPICall(required string RESTEndPoint,required string method,required boolean debug=false){
		return apiCall(arguments.RESTEndPoint,arguments.method,{},Arguments.debug);
	}
}