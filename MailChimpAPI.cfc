/**
* @file  MailChimpAPI
* @author Jonathan Smith
* @description MailChimp v3 API Wrapper for Coldfusion (Railo 4.x, Lucee 5)
* 
* 
*/

component extends="APIHelpers" accessors=true {
	property name="debug" type="boolean" setter="true";

	this.STATUS_SUBSCRIBED = "subscribed";
	this.STATUS_UNSUBSCRIBED = "unsubscribed";
	this.STATUS_CLEANED = "cleaned";
	this.STATUS_PENDING = "pending";

	public any function init(string apiKey,string serviceURL,numeric httpTimeout,boolean debug=false){
		super.init();
		processingdirective preserveCase="true";
		setServiceURL(arguments.serviceURL);		
		setApiKey(arguments.apikey);
		setDebug(arguments.debug);
		if (Val(Arguments.httpTimeout) gt 0){
			setHttpTimeout(arguments.httpTimeout);
		}
		return this;
	}	
	public struct function getLists(){
		return apiCall("/lists","GET",getDebug());
	}
	public struct function getListMembers(required string listId){		
		return apiCall("/lists/#arguments.listId#/members","GET",{},getDebug());		
	}

	// http://kb.mailchimp.com/api/article/how-to-manage-subscribers
	public APIResponse function addMember(required string listId, required string email, required struct mergeFields){		
		var requestBody = {
			email_address = lCase(Arguments.email),
			status = this.STATUS_SUBSCRIBED,
			merge_fields = Arguments.mergeFields
		};
		return apiCall("/lists/#arguments.listId#/members","POST",requestBody,getDebug());
	}
	public APIResponse function updateMember(required string listId, required string email,string status,required struct mergeFields){		
		var emailMD5 = hashAsMD5(arguments.email);
		var requestBody = {			
			merge_fields = Arguments.mergeFields
		};
		if (Arguments.status neq ""){
			requestBody.status = Arguments.status;
		}
		return apiCall("/lists/#arguments.listId#/members/#emailMD5#","PATCH",requestBody,getDebug());
	}
	public APIResponse function getMember(required string listId, required string email){		
		var emailMD5 = hashAsMD5(arguments.email);
		return apiCall("/lists/#arguments.listId#/members/#emailMD5#","GET",{},getDebug());
	}
	public APIResponse function manualAPICall(required string RESTEndPoint,required string method){
		return apiCall(arguments.RESTEndPoint,arguments.method,{},getDebug());
	}
	private string function hashAsMD5(required string t){
		// Mail Chimp API v3: "we identify your subscribers by the MD5 
		// hash of the lowercase version of their email address"
		return hash(lCase(arguments.t),"MD5");
	}
}